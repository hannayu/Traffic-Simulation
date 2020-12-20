% This file creates a directed graph representation of our system of roads.
% From the graph, we derive ni, nb, i1, i2, xi, yi, nbin, nbout, bin, bout,
% ux, uy, and L.
DGraph

%% Basic info (input manually if not for directed graph)
ni = G.numnodes;    %number of intersections (square)
nb = G.numedges;    %number of blocks
[i1,i2] = findedge(G); %block ends

% Intersection coordinates
[xi,yi] = meshgrid(linspace(1,navenues, navenues), ...
    linspace(1,nstreets,nstreets));
xi = xi';
yi = yi';

%% Derive info about blocks coming in and out of each intersection
% Derive nbin and nbout, the indegree and outdegree of each intersection
nbin = indegree(G);
nbout = outdegree(G);

nbinmax = max(nbin);
nboutmax = max(nbout);
% Derive bin and bout, which store the index of the blocks going in
% and out at each intersection
bin = zeros(ni, nbinmax);
bout = zeros(ni, nboutmax);
for i = 1:ni
    bin(i, 1:nbin(i)) = find(i2==i);
    bout(i, 1:nbout(i)) = find(i1==i);
end

%% Derive geometric info about roads
ux = xi(i2) - xi(i1); %vector from i1 to i2
uy = yi(i2) - yi(i1);
L = sqrt(ux.^2 + uy.^2);
ux = ux./L;  %normalize
uy = uy./L;  %normalize