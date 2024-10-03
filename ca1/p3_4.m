ts = 1e-9;
T = 1e-5;
tau = 1e-6;
R = 450;
a = 0.5;
C = physconst('LightSpeed');
num_iterations = 1000;
step_noise = 0.05;
max_noise = 3.5;

time = 0:ts:T;
td = 2 * R / C;

signal = (time >= 0) & (time <= tau);

signalR = (time >= td) & (time <= tau + td);
signalR = signalR * a;

noise_var = 0:step_noise:max_noise;

for i = 1:length(noise_var)
    total_error = 0;
    for j = 1:num_iterations
        noise = noise_var(i) * randn(size(received_signal));
        noisy_received_signal = received_signal + noise;
        
        [correlation, lag] = xcorr(noisy_received_signal, transmitted_signal);
        
        [~, max_index] = max(correlation);
        estimated_delay = lag(max_index) * ts;
        
        estimated_R = (estimated_delay * C) / 2;
        
        error_in_R = abs(estimated_R - R);
        total_error = total_error + error_in_R;
    end
    % plot(noisy_received_signal);
    estimated_R_errors(i) = total_error / num_iterations;
end

figure;
plot(noise_var, estimated_R_errors, 'b-o', 'LineWidth', 1.5);
title('Error in Distance Estimation vs noise');
xlabel('Noise');
ylabel('Error in Distance Estimation (m)');
grid on;