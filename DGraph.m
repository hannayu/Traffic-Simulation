G = digraph;
% navenues = 8;
% nstreets = 6;

%create first street
nnode = 1;
for i = 1:navenues-1
    G = addnode(G,1);
    nnode = nnode+1;
    G = addedge(G,nnode-1,nnode,1);
end

for j = 1:nstreets-1
    %create avenues with alternating directions
    n = G.numnodes;
    for i = (n-(navenues-1)):n
        G = addnode(G,1);
        if mod(i,2)
            G = addedge(G,G.numnodes,i,1);
        else
            G = addedge(G,i,G.numnodes,1);
        end
    end
    
    %create streets with alternating directions
    n = G.numnodes; 
    for i = 1:navenues-1
        if mod(j,2)
            G = addedge(G,n-i+1,(n-i+1)-1, 1);
        else
            G = addedge(G,(n-i+1)-1, n-i+1, 1);
        end
    end
end

% figure(10);
% plot(G)