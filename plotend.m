b = 1:nb;
plot([xi(i1(b)),xi(i2(b))]', [yi(i1(b)), yi(i2(b))]', 'b');
hold on
hcars = plot(0, 0, 'ko');
quiver(xi(i1(b)),yi(i1(b)),ux,uy)
hold off
axis equal; axis([0,navenues+1,0,nstreets+1])
set(gcf, 'Position', get(0, 'Screensize'));

hold on
if (nc>0 && sum(onroad)>0)
    set(hcars, 'xdata', x(find(onroad)), 'ydata', y(find(onroad)))
end
hold off

time = sprintf('time = %f/%d \nR = %f \nprchoice = %f',...
    t, clockmax*dt, R, prchoice);
legend(time)

drawnow