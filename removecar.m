onroad(c) = 0; texit(c) = t;
if (c == firstcar(b))
    firstcar(b) = nextcar(c);
    if (c==lastcar(b))
        lastcar(b) = 0;
    end
else
    nextcar(ca) = nextcar(c);
    if (c==lastcar(b))
        lastcar(b) = ca;
    end
end
        