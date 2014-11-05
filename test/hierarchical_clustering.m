function cluster_idx = hierarchical_clustering(image, cutoff)
keyboard;
% Current problem:
% does not have enough ram to do clustering for the whole data set
% n observations needs (n+1)*n/2 storage space
% Procedures:
% get the memory available
% repeat
%     random sample the data with size within available memory
%     build partial cluster centroids
% until all data are clustered
% cluster the centroids
% reference:
% https://stackoverflow.com/questions/2946087/out-of-memory-error-while-using-clusterdata-in-matlab

cluster_idx = clusterdata(image, cutoff);
end