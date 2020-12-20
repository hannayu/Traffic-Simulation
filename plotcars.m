hold on
if (nc>0 && sum(onroad)>0)
    set(hcars, 'xdata', x(find(onroad)), 'ydata', y(find(onroad)))
end
hold off

time = sprintf('time = %f/%d \nR = %f \nprchoice = %f',...
    t, clockmax*dt, R, prchoice);
legend(time)

drawnow