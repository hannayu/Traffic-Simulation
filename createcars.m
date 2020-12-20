% For each block b, decide if/where a new car appears
for b = 1:nb
    if (rand < dt*R*L(b)) %R is a constant
        nc = nc+1; %index of new car
        p(nc) = rand*L(b); %initialize position of the car
        x(nc) = xi(i1(b)) + p(nc)*ux(b);  %initialize x-coord
        y(nc) = yi(i1(b)) + p(nc)*uy(b);  %initialize y-coord
        distancetraveled(nc) = 0;  %initialize distance traveled
        
        % Put the car on the road
        onroad(nc) = 1;
        insertnewcar;  %updates the linked list of block b
        
        % Choose destination and compute shortest path
        choosedestination;
        nextb(nc)= b;   %for car c, set the block to be on next
        
        % Save entry information
        tenter(nc) = t; %save time of entering to current time t
        texit(nc) = 0;  %dummy time of exit
        benter(nc) = b; %save the block c entered from
        penter(nc) = p(nc); %save the position c entered from
    end
end
