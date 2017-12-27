function E = addDoor(E, xsource,ysource, xdest, ydest)
        E.map(ysource+(xsource-1)*E.y,ydest+(xdest-1)*E.y)=0;
        E.map(ydest+(xdest-1)*E.y,ysource+(xsource-1)*E.y)=0;
        E.pmap(ysource+(xsource-1)*E.y,ydest+(xdest-1)*E.y)=1;
        E.pmap(ydest+(xdest-1)*E.y, ysource+(xsource-1)*E.y)=1;
end