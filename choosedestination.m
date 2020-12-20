% Use method of rejection to choose a block with probability proportioned
% to its legth, and with p uniformly distributed in that block.

bd(nc) = 1 + floor(rand*nb);    %choose random block
pd(nc) = rand*max(L);           %choose random position on the block
while (pd(nc) >= L(bd(nc)))
    bd(nc) = 1 + floor(rand*nb);
    pd = rand*Lmax;
end

% Calculate destination coordinates
xd(nc) = xi(i1(bd(nc))) + pd(nc)*ux(bd(nc));
yd(nc) = yi(i1(bd(nc))) + pd(nc)*uy(bd(nc));

%% For shortest path steering
if (useshortestpath)
    % Find the shortest path to the destination
    % Note that we must add the last end i2(bd(nc)) for decidenextblock.m to work
    newpath = [shortestpath(G, i2(b), i1(bd(nc))), i2(bd(nc))];
    newpath(end+1:navenues*nstreets) = 0;  %extend with zeros

    % Save shortest path and save progress
    destinationpath(nc,:) = newpath;
    progress(nc) = 1;
end