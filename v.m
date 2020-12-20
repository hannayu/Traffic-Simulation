% This function assumes instantaneous adjustment of velocity with no
% regard for reaction time. With this function, accidents never happen
% because the second you get too close, you stop.

function vv = v(d)
global dmin dmax vmax;

if (d < dmin)
  vv = 0; %velodity is zero if you are closer to the car ahead than dmin
elseif (d < dmax) 
  vv = vmax * log(d/dmin)/log(dmax/dmin); %concave function normalized so fraction is out of 1 
else
  vv = vmax; %velocity you go at if there is no car ahead
end

% optimal distance is e*dmin that maximizes throughput