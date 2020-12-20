%% Rotate the green light through the blocks at each intersection
if t > tlc
    %Is it time for the lights to change yet?
    for i = 1:ni
        %for each intersection
        jgreen(i) = jgreen(i) + 1;  %rotate index to next block
        if (jgreen(i) > nbin(i))
            jgreen(i) = 1;
        end
    end
    tlc = tlc + tlcstep;  %update time of next light change
end

%% Set the state of each block, 1 for green, 0 for red
s = zeros(1, nb); 

% Find block with green light and set the state
for i = 1:ni
    b = bin(i, jgreen(i)); %retrieve index of block with the green light
    s(b) = 1;  %1 means the light is green, 0 for red
end
    