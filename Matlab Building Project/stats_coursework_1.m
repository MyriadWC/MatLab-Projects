function main

rc_dat = 0;
steel_dat = 0;

load ('HK_build_cost.mat');

C1_rc_dat = rc_dat(:,[1]); % Average Floor Area (m2) %
C2_rc_dat = rc_dat(:,[2]); % Total Floor Area (m2) %
C3_rc_dat = rc_dat(:,[3]); % Story Height (m) %
C4_rc_dat = rc_dat(:,[4]); % Adjusted Construction cost (HK$; this is the variable to estimate) %

C1_steel_dat = steel_dat(:,[1]);
C2_steel_dat = steel_dat(:,[2]);
C3_steel_dat = steel_dat(:,[3]);
C4_steel_dat = steel_dat(:,[4]);

figure

% Column 1 Average Floor Area %
subplot (4,4,1)
histogram(C1_rc_dat,'FaceColor','b')
hold on
histogram(C1_steel_dat,'FaceColor','r')
hold off
xlabel('Average Floor Area (m2)')

subplot(4,4,5)
plot(C1_rc_dat,C2_rc_dat,'x')
hold on
plot(C1_steel_dat,C2_steel_dat,'x')
hold off
xlabel('Average Floor area')
ylabel('Total Floor area')

subplot(4,4,9)
plot(C1_rc_dat,C3_rc_dat,'x')
hold on
plot(C1_steel_dat,C3_steel_dat,'x')
hold off
xlabel('Average Floor area')
ylabel('Story height')

subplot(4,4,13)
plot(C1_rc_dat,C4_rc_dat,'x')
xlabel('Average Floor area')
ylabel('Adjusted Construction cost')

% Column 2 Total Floor Area
subplot (4,4,2)
plot(C2_rc_dat, C1_rc_dat, 'x')
xlabel('Total Floor area')
ylabel('Average Floor area')

subplot(4,4,6)
hist(C2_rc_dat)
xlabel('Total Floor area')

subplot(4,4,10)
plot(C2_rc_dat, C3_rc_dat, 'x')
xlabel('Total Floor area')
ylabel('Story height')

subplot(4,4,14)
plot(C2_rc_dat, C4_rc_dat, 'x')
xlabel('Total Floor area')
ylabel('Adjusted construction cost')

% Column 3 Story height
subplot(4,4,3)
plot(C3_rc_dat, C1_rc_dat, 'x')
xlabel('Story height')
ylabel('Average Floor area')

subplot(4,4,7)
plot(C3_rc_dat, C2_rc_dat, 'x')
xlabel('Story height')
ylabel('Total Floor area')

subplot(4,4,11)
hist(C3_rc_dat)
xlabel('Story height')

subplot(4,4,15)
plot(C3_rc_dat, C4_rc_dat, 'x')
xlabel('Story height')
ylabel('Adjusted construction cost')

% Column 4 Adjusted Construction cost
subplot(4,4,4)
plot(C4_rc_dat, C1_rc_dat, 'x')
xlabel('Adjusted construction cost')
ylabel('Average Floor area')

subplot(4,4,8)
plot(C4_rc_dat, C2_rc_dat, 'x')
xlabel('Adjusted construction cost')
ylabel('Total Floor area')

subplot(4,4,12)
plot(C4_rc_dat, C3_rc_dat, 'x')
xlabel('Adjusted construction cost')
ylabel('Story height')

subplot(4,4,16)
hist(C4_rc_dat)
xlabel('Adjusted construction cost')

end