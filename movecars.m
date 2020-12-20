% Note that cars increase in position from i1 (where they start) to i2
% (where they reach the end of the block, where the lines of cars starts)

for b = 1:nb  %for every block
    c = firstcar(b);
    
    while (c>0)  %while cars still exist on the block
        %% Calculate distances (for velocity function)
        if (c==firstcar(b))
            %c is the first car on the block
            if (bd(c)==b) && (pd(c)>p(c))
                %car is on its destination block
                d = dmax;
            elseif (s(b)==0)
                %light is red
                d = L(b)-p(c); %distance betw car and i2
            else
                %turn into a block
                decidenextblock  %update nextb(c)     
                if (lastcar(nextb(c))>0)
                    %there is a car in the next block
                    %calculate distance betw c and car in the next block
                    d = (L(b)-p(c)) + p(lastcar(nextb(c)));  
                else
                    %no car in next block
                    d = dmax;
                end
            end
        else
            %c is not the first car on the block
            d = p(ca)-p(c); %distance between car c and car ahead
        end
        
        %% Update position, linked lists, coordinates, distance traveled
        pz = p(c); % save previous car position
        nextc = nextcar(c);
        p(c) = p(c) + dt*v(d);  %update car position (see v.m for v)

        if (b==bd(c)) && (pz<pd(c)) && (pd(c)<=p(c))
            % If destination is in the car's path
            distancetraveled(c) = distancetraveled(c) + (pd(c)-pz);
            removecar
        elseif (p(c) >= L(b))
            % If car surpasses length of block
            distancetraveled(c) = distancetraveled(c) + (L(b)-pz);
            p(c) = p(c)-L(b);  %calculate position on next block
            
            if (useshortestpath)
                progress(c) = progress(c) + 1;  %increment progress
            end
            
            if (nextb(c)==bd(c)) && (pd(c)<=p(c))
                % If destination is on next block
                distancetraveled(c) = distancetraveled(c) + pd(c);
                removecar
            else
                distancetraveled(c) = distancetraveled(c) + p(c);
                % Update prev and next block's linked lists
                % and update car c's coordinates
                cartonextblock 
            end
        else
            % If car stays on the same block after moving
            distancetraveled(c) = distancetraveled(c) + (p(c)-pz);
            x(c) = xi(i1(b)) + p(c)*ux(b);
            y(c) = yi(i1(b)) + p(c)*uy(b);
            ca = c;
        end
        c = nextc;  %go to the next car on the block
    end
end