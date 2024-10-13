function clusters = DBSCAN(D, eps, MinPts)
    C = 0;
    n = size(D, 1);
    visited = false(n, 1);
    clusters = zeros(n, 1);

    for i = 1:n
        if ~visited(i)
            visited(i) = true;
            NeighborPts = regionQuery(D, i, eps);

            if numel(NeighborPts) < MinPts
                clusters(i) = 0;
            else
                C = C + 1;
                [clusters, visited] = expandCluster(D, clusters, i, NeighborPts, C, eps, MinPts, visited);
            end
        end
    end
end

function [clusters, visited] = expandCluster(D, clusters, i, NeighborPts, C, eps, MinPts, visited)
    clusters(i) = C;

    k = 1;
    while k <= length(NeighborPts)
        j = NeighborPts(k);

        if ~visited(j)
            visited(j) = true;
            NeighborPts_j = regionQuery(D, j, eps);

            if numel(NeighborPts_j) >= MinPts
                NeighborPts = unique([NeighborPts; NeighborPts_j]);
            end
        end

        if clusters(j) == 0
            clusters(j) = C;
        end

        k = k + 1;
    end
end

function NeighborPts = regionQuery(D, i, eps)
    distances = sum(abs(D - D(i, :)), 2);
    NeighborPts = find(distances <= eps);
end