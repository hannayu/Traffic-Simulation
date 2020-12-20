%% System constants
constants = zeros(7,1);
constants(1) = nstreets;
constants(2) = navenues;
constants(3) = tlcstep;
constants(4) = R;
constants(5) = dt*clockmax;
constants(6) = useshortestpath;
constants(7) = seed;
constants(8) = prchoice;

%% Car Data
tentersize = size(tenter);
nrows = tentersize(2);

cardata = zeros(nrows, 7);
cardata(:,1) = tenter';                                     
cardata(:,2) = texit'; 
cardata(:,3) = xi(i1(benter)) + ux(benter).*penter';        %x-coord enter
cardata(:,4) = yi(i1(benter)) + uy(benter).*penter';        %y-coord enter
cardata(:,5) = xd';                                         %x-coord dest
cardata(:,6) = yd';                                         %y-coord dest                                
cardata(:,7) = (cardata(:,2)>0).*(cardata(:,2)-cardata(:,1)) ... 
    + (cardata(:,2)==0).*(t*ones(nrows,1)-cardata(:,1));    %time on road               
cardata(:,8) = distancetraveled;                            %distance
cardata(:,9) = distancetraveled'./cardata(:,7);             %speed

%% Stats
stats = zeros(4,1);
numonroad = size(find(onroad));
stats(1) = sum(max(zeros(nrows,1), cardata(:,2)-cardata(:,1)))...     
    /(tentersize(2)-numonroad(2));                     %avg time to dest
stats(2) = sum(cardata(:,9))./nrows;                   %avg speed
stats(3) = (tentersize(2)-numonroad(2))/tentersize(2); %perc. reach dest
stats(4) = sum(onroad);                                %num on road

%% Write into Excel file
sheetnum = 2;
writematrix(constants,'data.xls','Sheet', sheetnum, 'Range','B1:B8')
writematrix(stats,'data.xls','Sheet', sheetnum, 'Range','B10:B13')
writematrix(cardata,'data.xls','Sheet', sheetnum, 'Range','D2:L10000')
