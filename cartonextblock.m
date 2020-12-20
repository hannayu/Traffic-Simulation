% Move a car from block b to next block

% Update block b's linked list
firstcar(b) = nextcar(c);  
if (c==lastcar(b))  
    lastcar(b) = 0;
end

% Update next block's linked list
if (lastcar(nextb(c)) == 0)
    firstcar(nextb(c)) = c; 
else
    nextcar(lastcar(nextb(c))) = c;
end
lastcar(nextb(c)) = c;
nextcar(c) = 0;

% Update coordinates of car c
x(c) = xi(i1(nextb(c))) + p(c)*ux(nextb(c));
y(c) = xi(i1(nextb(c))) + p(c)*uy(nextb(c));