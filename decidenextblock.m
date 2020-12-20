% This file runs only if c is now the first car on block b. The file
% determines nextb which is the block car c should turn into next.

if (nextb(c)==b)  %true if they were not the first car before
    i = i2(b);  
    
    if (useshortestpath)
        %Find nextb by using shortest path algorithm
        nextbi1 = destinationpath(c, progress(c));      %find i1(nextb)
        nextbi2 = destinationpath(c, progress(c)+1);    %find i2(nextb)
        nextb(c) = find((i1==nextbi1) & (i2==nextbi2)); %find nextb
    else   
        %Find nextb by using dot product and prchoice
        if (rand < prchoice) %pick a random block

            % From all the blocks going out of i2, pick one of them
            jnext = 1 + floor(rand*nbout(i)); 

            % Let jnext be the block that car c turns into
            nextb(c) = bout(i, jnext); 

        else  %chose block that leads closest to destination

            % Calculate the vector between the current position and destination
            xdvec = xd(c) - xi(i);
            ydvec = yd(c) - yi(i);

            % Calculate dot product with all out blocks
            dp = ux(bout(i, 1:nbout(i))) * xdvec...
                + uy(bout(i, 1:nbout(i))) * ydvec;
            [dpmax,jnext] = max(dp);  % choose block that gives greatest dp

            % Let jnext be the block that car c turns into
            nextb(c) = bout(i, jnext);
        end
    end
    
end
