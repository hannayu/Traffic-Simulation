clear all
close all

% Settings
recordvideo = 1;
drawplot = 1;

if (recordvideo)
    video = VideoWriter('video','MPEG-4');
    open(video)
end

%% Initialize values

% Initialize intersections and blocks
navenues = 4;
nstreets = 4;
createroadsdgraph
    
% Initialize lights (for setlights.m)
tlcstep = 1;         %time interval between light changes
tlc = tlcstep;       %tlc is the time of the next light change
jgreen = ones(1,ni); %initialize green light for i to be block at bin(i,1)

% Initialize cars (for createcars.m)
R = 0.05;  %rate that cars get created
nc = 0;
firstcar = zeros(1,nb);
lastcar = zeros(1,nb);

% Initialize steering (for movecars.m, decidenextblock.m)
seed = 1;
rng(seed);
useshortestpath = 0;
prchoice = 0;  %probability of random steering

% Initialize (for v.m, called in movecars.m)
global dmin dmax vmax
dmin = 0.05;  %distance between you and car ahead will never go below this
dmax = 0.5;
vmax = 1;

%% Initialize plot
if (drawplot)
    b = 1:nb;
    plot([xi(i1(b)),xi(i2(b))]', [yi(i1(b)), yi(i2(b))]', 'b');
    hold on
    hcars = plot(0, 0, 'ko');
    quiver(xi(i1(b)),yi(i1(b)),ux,uy)
    hold off
    axis equal; axis([0,navenues+1,0,nstreets+1])
    set(gcf, 'Position', get(0, 'Screensize'));
end

%% Main Loop
clockmax = 1000; %4000 to 128000 %number of clock counts
dt = 0.01;
for clock = 1:clockmax  %clock is a counter
    t = clock*dt;
    clc
    disp(t);
    
    setlights;
    createcars;
    movecars;
    
    if (drawplot)
        plotcars;
    end
    
    if (recordvideo)
        writeVideo(video,getframe(gcf));
    end
end

if (recordvideo)
	close(video)
end

% RecordData