load ('HK_build_cost.mat');

% Loading all data columns into variables %

rc_floor_area = rc_dat(:, 1);
rc_total_floor_area = rc_dat(:, 2);
rc_storey_height = rc_dat(:, 3);
rc_adjusted_construction_cost = rc_dat(:, 4);

steel_floor_area = steel_dat(:, 1);
steel_total_floor_area = steel_dat(:, 2);
steel_storey_height = steel_dat(:, 3);
steel_adjusted_construction_cost = steel_dat(:, 4);

% Plotting all combinations of variables as scatter plots and histograms of each variable %

figure(1)

% column 1
subplot (4,4,1)

histogram(rc_floor_area, ceil(sqrt(numel(rc_floor_area))))
hold on
histogram(steel_floor_area, ceil(sqrt(numel(steel_floor_area))))
hold off
legend('Reinforced Concrete', 'Steel')
title("Floor Area (m^2)")
ylabel("Frequency")

subplot(4,4,5)

scatter(rc_floor_area, rc_total_floor_area)
hold on
scatter(steel_floor_area, steel_total_floor_area)
hold off
xlabel("Floor Area (m^2)")
ylabel("Total Floor Area (m^2)")

subplot(4,4,9)

scatter(rc_floor_area, rc_storey_height)
hold on
scatter(steel_floor_area, steel_storey_height)
hold off
xlabel("Floor Area (m^2)")
ylabel("Storey Height (m)")

subplot(4,4,13)

scatter(rc_floor_area, rc_adjusted_construction_cost)
hold on
scatter(steel_floor_area, steel_adjusted_construction_cost)
hold off
xlabel("Floor Area (m^2)")
ylabel("Adjusted Construction Cost (HK$)")


% column 2
subplot (4,4,2)

scatter(rc_total_floor_area, rc_floor_area)
hold on
scatter(steel_total_floor_area, steel_floor_area)
hold off
xlabel("Total Floor Area (m^2)")
ylabel("Floor Area (m^2)")

subplot(4,4,6)

histogram(rc_total_floor_area, ceil(sqrt(numel(rc_total_floor_area))))
hold on
histogram(steel_total_floor_area, ceil(sqrt(numel(steel_total_floor_area))))
hold off
title("Total Floor Area (m^2)")
ylabel("Frequency")

subplot(4,4,10)

scatter(rc_total_floor_area, rc_storey_height)
hold on
scatter(steel_total_floor_area, steel_storey_height)
hold off
xlabel("Total Floor Area (m^2)")
ylabel("Storey Height (m)")

subplot(4,4,14)

scatter(rc_total_floor_area, rc_adjusted_construction_cost)
hold on
scatter(steel_total_floor_area, steel_adjusted_construction_cost)
hold off
xlabel("Total Floor Area (m^2)")
ylabel("Adjusted Construction Cost (HK$)")

% column 3

subplot (4,4,3)

scatter(rc_storey_height, rc_floor_area)
hold on
scatter(steel_storey_height, steel_floor_area)
hold off
xlabel("Storey Height (m)")
ylabel("Floor Area (m^2)")

subplot(4,4,7)

scatter(rc_storey_height, rc_total_floor_area)
hold on
scatter(steel_storey_height, steel_total_floor_area)
hold off
xlabel("Storey Height (m)")
ylabel("Total Floor Area (m^2)")

subplot(4,4,11)

histogram(rc_storey_height, ceil(sqrt(numel(rc_storey_height))))
hold on
histogram(steel_storey_height, ceil(sqrt(numel(steel_storey_height))))
hold off
title("Storey Height (m)")
ylabel("Frequency")

subplot(4,4,15)

scatter(rc_storey_height, rc_adjusted_construction_cost)
hold on
scatter(steel_storey_height, steel_adjusted_construction_cost)
hold off
xlabel("Storey Height (m)")
ylabel("Adjusted Construction Cost (HK$)")


% column 4:

subplot (4,4,4)

scatter(rc_adjusted_construction_cost, rc_floor_area)
hold on
scatter(steel_adjusted_construction_cost, steel_floor_area)
hold off
xlabel("Adjusted Construction Cost (HK$)")
ylabel("Floor Area (m^2)")

subplot(4,4,8)

scatter(rc_adjusted_construction_cost, rc_total_floor_area)
hold on
scatter(steel_adjusted_construction_cost, steel_total_floor_area)
hold off
xlabel("Adjusted Construction Cost (HK$)")
ylabel("Total Floor Area (m^2)")

subplot(4,4,12)

scatter(rc_adjusted_construction_cost, rc_storey_height)
hold on
scatter(steel_adjusted_construction_cost, steel_storey_height)
hold off
xlabel("Adjusted Construction Cost (HK$)")
ylabel("Storey Height (m)")

subplot(4,4,16)

histogram(rc_adjusted_construction_cost, ceil(sqrt(numel(rc_adjusted_construction_cost))))
hold on
histogram(steel_adjusted_construction_cost, ceil(sqrt(numel(steel_adjusted_construction_cost))))
hold off
title("Adjusted Construction Cost (HK$)")
ylabel("Frequency")

% Question 2 %

input("Press enter to continue to question 2...\n\n");
fprintf("Question 2\n\n");

% All variables individually modelled against cost to calculate R^2 and R^2 adjusted %

% Reinforced concrete %

rc_adjusted_construction_cost_mean = sum(rc_adjusted_construction_cost) / numel(rc_adjusted_construction_cost);
rc_p = 3;

% average floor area against cost %

rc_floor_area_n = numel(rc_adjusted_construction_cost);

rc_floor_area_ones = ones(numel(rc_floor_area), 1);

rc_floor_area_with_constant =        [rc_floor_area rc_floor_area_ones];
rc_floor_area_regress_model =        regress(rc_adjusted_construction_cost, rc_floor_area_with_constant);
rc_floor_area_regress_model_beta_0 = rc_floor_area_regress_model(2); %Big number at start%
rc_floor_area_regress_model_beta_1 = rc_floor_area_regress_model(1); %Regression coefficient%

% This should calculate values for every array element %
rc_floor_area_construction_cost_estimation = rc_floor_area_regress_model_beta_0 + rc_floor_area_regress_model_beta_1 * rc_floor_area;
rc_floor_area_SSe = sum((rc_adjusted_construction_cost - rc_floor_area_construction_cost_estimation).^2);
rc_floor_area_SSt = sum((rc_adjusted_construction_cost - rc_adjusted_construction_cost_mean).^2);

rc_floor_area_r_squared = 1 - (rc_floor_area_SSe) / (rc_floor_area_SSt);
rc_floor_area_r_squared_adjusted = 1 - (rc_floor_area_SSe*(rc_floor_area_n - 1))/(rc_floor_area_SSt*(rc_floor_area_n - rc_p));

% Total floor area against cost %

rc_total_floor_area_n = numel(rc_adjusted_construction_cost);

rc_total_floor_area_ones = ones(numel(rc_total_floor_area), 1);

rc_total_floor_area_with_constant =        [rc_total_floor_area rc_total_floor_area_ones];
rc_total_floor_area_regress_model =        regress(rc_adjusted_construction_cost, rc_total_floor_area_with_constant);
rc_total_floor_area_regress_model_beta_0 = rc_total_floor_area_regress_model(2); %Big number at start%
rc_total_floor_area_regress_model_beta_1 = rc_total_floor_area_regress_model(1); %Regression coefficient%

% This should calculate values for every array element %
rc_total_floor_area_construction_cost_estimation = rc_total_floor_area_regress_model_beta_0 + rc_total_floor_area_regress_model_beta_1 * rc_total_floor_area;
rc_total_floor_area_SSe = sum((rc_adjusted_construction_cost - rc_total_floor_area_construction_cost_estimation).^2);
rc_total_floor_area_SSt = sum((rc_adjusted_construction_cost - rc_adjusted_construction_cost_mean).^2);

rc_total_floor_area_r_squared = 1 - (rc_total_floor_area_SSe) / (rc_total_floor_area_SSt);
rc_total_floor_area_r_squared_adjusted = 1 - (rc_total_floor_area_SSe*(rc_total_floor_area_n - 1))/(rc_total_floor_area_SSt*(rc_total_floor_area_n - rc_p));

% storey height against cost %

rc_storey_height_n = numel(rc_adjusted_construction_cost);

rc_storey_height_ones = ones(numel(rc_storey_height), 1);

rc_storey_height_with_constant =        [rc_storey_height rc_storey_height_ones];
rc_storey_height_regress_model =        regress(rc_adjusted_construction_cost, rc_storey_height_with_constant);
rc_storey_height_regress_model_beta_0 = rc_storey_height_regress_model(2); %Big number at start%
rc_storey_height_regress_model_beta_1 = rc_storey_height_regress_model(1); %Regression coefficient%

% This should calculate values for every array element %
rc_storey_height_construction_cost_estimation = rc_storey_height_regress_model_beta_0 + rc_storey_height_regress_model_beta_1 * rc_storey_height;
rc_storey_height_SSe = sum((rc_adjusted_construction_cost - rc_storey_height_construction_cost_estimation).^2);
rc_storey_height_SSt = sum((rc_adjusted_construction_cost - rc_adjusted_construction_cost_mean).^2);

rc_storey_height_r_squared = 1 - (rc_storey_height_SSe) / (rc_storey_height_SSt);
rc_storey_height_r_squared_adjusted = 1 - (rc_storey_height_SSe*(rc_storey_height_n - 1))/(rc_storey_height_SSt*(rc_storey_height_n - rc_p));

rc_adjusted_construction_cost_mean = sum(rc_adjusted_construction_cost) / numel(rc_adjusted_construction_cost);

% Steel %

rc_adjusted_construction_cost_mean = sum(rc_adjusted_construction_cost) / numel(rc_adjusted_construction_cost);
rc_p = 3;

% average floor area against cost %

rc_floor_area_n = numel(rc_adjusted_construction_cost);

rc_floor_area_ones = ones(numel(rc_floor_area), 1);

rc_floor_area_with_constant =        [rc_floor_area rc_floor_area_ones];
rc_floor_area_regress_model =        regress(rc_adjusted_construction_cost, rc_floor_area_with_constant);
rc_floor_area_regress_model_beta_0 = rc_floor_area_regress_model(2); %Big number at start%
rc_floor_area_regress_model_beta_1 = rc_floor_area_regress_model(1); %Regression coefficient%

% This should calculate values for every array element %
rc_floor_area_construction_cost_estimation = rc_floor_area_regress_model_beta_0 + rc_floor_area_regress_model_beta_1 * rc_floor_area;
rc_floor_area_SSe = sum((rc_adjusted_construction_cost - rc_floor_area_construction_cost_estimation).^2);
rc_floor_area_SSt = sum((rc_adjusted_construction_cost - rc_adjusted_construction_cost_mean).^2);

rc_floor_area_r_squared = 1 - (rc_floor_area_SSe) / (rc_floor_area_SSt);
rc_floor_area_r_squared_adjusted = 1 - (rc_floor_area_SSe*(rc_floor_area_n - 1))/(rc_floor_area_SSt*(rc_floor_area_n - p));

% Total floor area against cost %

rc_total_floor_area_n = numel(rc_adjusted_construction_cost);

rc_total_floor_area_ones = ones(numel(rc_total_floor_area), 1);

rc_total_floor_area_with_constant =        [rc_total_floor_area rc_total_floor_area_ones];
rc_total_floor_area_regress_model =        regress(rc_adjusted_construction_cost, rc_total_floor_area_with_constant);
rc_total_floor_area_regress_model_beta_0 = rc_total_floor_area_regress_model(2); %Big number at start%
rc_total_floor_area_regress_model_beta_1 = rc_total_floor_area_regress_model(1); %Regression coefficient%

% This should calculate values for every array element %
rc_total_floor_area_construction_cost_estimation = rc_total_floor_area_regress_model_beta_0 + rc_total_floor_area_regress_model_beta_1 * rc_total_floor_area;
rc_total_floor_area_SSe = sum((rc_adjusted_construction_cost - rc_total_floor_area_construction_cost_estimation).^2);
rc_total_floor_area_SSt = sum((rc_adjusted_construction_cost - rc_adjusted_construction_cost_mean).^2);

rc_total_floor_area_r_squared = 1 - (rc_total_floor_area_SSe) / (rc_total_floor_area_SSt);
rc_total_floor_area_r_squared_adjusted = 1 - (rc_total_floor_area_SSe*(rc_total_floor_area_n - 1))/(rc_total_floor_area_SSt*(rc_total_floor_area_n - p));

% storey height against cost %

rc_storey_height_n = numel(rc_adjusted_construction_cost);

rc_storey_height_ones = ones(numel(rc_storey_height), 1);

rc_storey_height_with_constant =        [rc_storey_height rc_storey_height_ones];
rc_storey_height_regress_model =        regress(rc_adjusted_construction_cost, rc_storey_height_with_constant);
rc_storey_height_regress_model_beta_0 = rc_storey_height_regress_model(2); %Big number at start%
rc_storey_height_regress_model_beta_1 = rc_storey_height_regress_model(1); %Regression coefficient%

% This should calculate values for every array element %
rc_storey_height_construction_cost_estimation = rc_storey_height_regress_model_beta_0 + rc_storey_height_regress_model_beta_1 * rc_storey_height;
rc_storey_height_SSe = sum((rc_adjusted_construction_cost - rc_storey_height_construction_cost_estimation).^2);
rc_storey_height_SSt = sum((rc_adjusted_construction_cost - rc_adjusted_construction_cost_mean).^2);

rc_storey_height_r_squared = 1 - (rc_storey_height_SSe) / (rc_storey_height_SSt);
rc_storey_height_r_squared_adjusted = 1 - (rc_storey_height_SSe*(rc_storey_height_n - 1))/(rc_storey_height_SSt*(rc_storey_height_n - p));

% Multivariate (all 3) %
 
rc_multivariate_n = numel(rc_adjusted_construction_cost);
 
rc_multivariate_ones = ones(numel(rc_storey_height), 1);
 
rc_multivariate_with_constant =        [rc_multivariate_ones rc_floor_area rc_total_floor_area rc_storey_height];
rc_multivariate_regress_model =        regress(rc_adjusted_construction_cost, rc_multivariate_with_constant);
rc_multivariate_regress_model_beta_0 = rc_multivariate_regress_model(1);
rc_multivariate_regress_model_beta_1 = rc_multivariate_regress_model(2);
rc_multivariate_regress_model_beta_2 = rc_multivariate_regress_model(3);
rc_multivariate_regress_model_beta_3 = rc_multivariate_regress_model(4);
 
% This should calculate values for every array element %
rc_multivariate_construction_cost_estimation = rc_multivariate_regress_model_beta_0 + rc_multivariate_regress_model_beta_1 * rc_floor_area + rc_multivariate_regress_model_beta_2 * rc_total_floor_area + rc_multivariate_regress_model_beta_3 * rc_storey_height;
                                                
rc_multivariate_SSe = sum((rc_adjusted_construction_cost - rc_multivariate_construction_cost_estimation).^2);
rc_multivariate_SSt = sum((rc_adjusted_construction_cost - rc_adjusted_construction_cost_mean).^2);
 
rc_multivariate_r_squared = 1 - (rc_multivariate_SSe) / (rc_multivariate_SSt);
rc_multivariate_r_squared_adjusted = 1 - (rc_multivariate_SSe*(rc_multivariate_n - 1))/(rc_multivariate_SSt*(rc_multivariate_n - p));

% Steel %
 
steel_adjusted_construction_cost_mean = sum(steel_adjusted_construction_cost) / numel(steel_adjusted_construction_cost);
steel_p = 3;
 
% Floor area against cost %
 
steel_floor_area_n = numel(steel_adjusted_construction_cost);
 
steel_floor_area_ones = ones(numel(steel_floor_area), 1);
 
steel_floor_area_with_constant =        [steel_floor_area steel_floor_area_ones];
steel_floor_area_regress_model =        regress(steel_adjusted_construction_cost, steel_floor_area_with_constant);
steel_floor_area_regress_model_beta_0 = steel_floor_area_regress_model(2); %Big number at start%
steel_floor_area_regress_model_beta_1 = steel_floor_area_regress_model(1); %Regression coefficient%
 
% This should calculate values for every array element %
steel_floor_area_construction_cost_estimation = steel_floor_area_regress_model_beta_0 + steel_floor_area_regress_model_beta_1 * steel_floor_area;
steel_floor_area_SSe = sum((steel_adjusted_construction_cost - steel_floor_area_construction_cost_estimation).^2);
steel_floor_area_SSt = sum((steel_adjusted_construction_cost - steel_adjusted_construction_cost_mean).^2);
 
steel_floor_area_r_squared = 1 - (steel_floor_area_SSe) / (steel_floor_area_SSt);
steel_floor_area_r_squared_adjusted = 1 - (steel_floor_area_SSe*(steel_floor_area_n - 1))/(steel_floor_area_SSt*(steel_floor_area_n - p));
 
% Total floor area against cost %
 
steel_total_floor_area_n = numel(steel_adjusted_construction_cost);
 
steel_total_floor_area_ones = ones(numel(steel_total_floor_area), 1);
 
steel_total_floor_area_with_constant =        [steel_total_floor_area steel_total_floor_area_ones];
steel_total_floor_area_regress_model =        regress(steel_adjusted_construction_cost, steel_total_floor_area_with_constant);
steel_total_floor_area_regress_model_beta_0 = steel_total_floor_area_regress_model(2); %Big number at start%
steel_total_floor_area_regress_model_beta_1 = steel_total_floor_area_regress_model(1); %Regression coefficient%
 
% This should calculate values for every array element %
steel_total_floor_area_construction_cost_estimation = steel_total_floor_area_regress_model_beta_0 + steel_total_floor_area_regress_model_beta_1 * steel_total_floor_area;
steel_total_floor_area_SSe = sum((steel_adjusted_construction_cost - steel_total_floor_area_construction_cost_estimation).^2);
steel_total_floor_area_SSt = sum((steel_adjusted_construction_cost - steel_adjusted_construction_cost_mean).^2);
 
steel_total_floor_area_r_squared = 1 - (steel_total_floor_area_SSe) / (steel_total_floor_area_SSt);
steel_total_floor_area_r_squared_adjusted = 1 - (steel_total_floor_area_SSe*(steel_total_floor_area_n - 1))/(steel_total_floor_area_SSt*(steel_total_floor_area_n - p));
 
% Storey height against cost %
 
steel_storey_height_n = numel(steel_adjusted_construction_cost);
 
steel_storey_height_ones = ones(numel(steel_storey_height), 1);
 
steel_storey_height_with_constant =        [steel_storey_height steel_storey_height_ones];
steel_storey_height_regress_model =        regress(steel_adjusted_construction_cost, steel_storey_height_with_constant);
steel_storey_height_regress_model_beta_0 = steel_storey_height_regress_model(2); %Big number at start%
steel_storey_height_regress_model_beta_1 = steel_storey_height_regress_model(1); %Regression coefficient%
 
% This should calculate values for every array element %
steel_storey_height_construction_cost_estimation = steel_storey_height_regress_model_beta_0 + steel_storey_height_regress_model_beta_1 * steel_storey_height;
steel_storey_height_SSe = sum((steel_adjusted_construction_cost - steel_storey_height_construction_cost_estimation).^2);
steel_storey_height_SSt = sum((steel_adjusted_construction_cost - steel_adjusted_construction_cost_mean).^2);
 
steel_storey_height_r_squared = 1 - (steel_storey_height_SSe) / (steel_storey_height_SSt);
steel_storey_height_r_squared_adjusted = 1 - (steel_storey_height_SSe*(steel_storey_height_n - 1))/(steel_storey_height_SSt*(steel_storey_height_n - p));
 
% Multivariate (all 3) %

steel_multivariate_n = numel(steel_adjusted_construction_cost);
 
steel_multivariate_ones = ones(numel(steel_storey_height), 1);
 
steel_multivariate_with_constant =        [steel_multivariate_ones steel_floor_area steel_total_floor_area steel_storey_height];
steel_multivariate_regress_model =        regress(steel_adjusted_construction_cost, steel_multivariate_with_constant);
steel_multivariate_regress_model_beta_0 = steel_multivariate_regress_model(1);
steel_multivariate_regress_model_beta_1 = steel_multivariate_regress_model(2);
steel_multivariate_regress_model_beta_2 = steel_multivariate_regress_model(3);
steel_multivariate_regress_model_beta_3 = steel_multivariate_regress_model(4);
 
% This should calculate values for every array element %
steel_multivariate_construction_cost_estimation = steel_multivariate_regress_model_beta_0 + steel_multivariate_regress_model_beta_1 * steel_floor_area + steel_multivariate_regress_model_beta_2 * steel_total_floor_area + steel_multivariate_regress_model_beta_3 * steel_storey_height;
                                                
steel_multivariate_SSe = sum((steel_adjusted_construction_cost - steel_multivariate_construction_cost_estimation).^2);
steel_multivariate_SSt = sum((steel_adjusted_construction_cost - steel_adjusted_construction_cost_mean).^2);
 
steel_multivariate_r_squared = 1 - (steel_multivariate_SSe) / (steel_multivariate_SSt);
steel_multivariate_r_squared_adjusted = 1 - (steel_multivariate_SSe*(steel_multivariate_n - 1))/(steel_multivariate_SSt*(steel_multivariate_n - p));

% Printing values %

fprintf("Values of R^2 and R^2 adjusted for given variable against adjusted construction cost in HK$:\n\n");
fprintf("Reinforced Concrete:\tR^2\t\tR^2 Adjusted\n");
fprintf("Average Floor Area\t%f\t%f\n", rc_floor_area_r_squared, rc_floor_area_r_squared_adjusted);
fprintf("Total Floor Area\t%f\t%f\n", rc_total_floor_area_r_squared, rc_total_floor_area_r_squared_adjusted);
fprintf("Storey Height\t\t%f\t%f\n", rc_storey_height_r_squared, rc_storey_height_r_squared_adjusted);
fprintf("All 3 regressors\t%f\t%f\n\n", rc_multivariate_r_squared, rc_multivariate_r_squared_adjusted);
 
fprintf("Steel:\t\t\tR^2\t\tR^2 Adjusted\n");
fprintf("Average Floor Area\t%f\t%f\n", steel_floor_area_r_squared, rc_floor_area_r_squared_adjusted);
fprintf("Total Floor Area\t%f\t%f\n", steel_total_floor_area_r_squared, steel_total_floor_area_r_squared_adjusted);
fprintf("Storey Height\t\t%f\t%f\n", steel_storey_height_r_squared, steel_storey_height_r_squared_adjusted);
fprintf("All 3 regressors\t%f\t%f\n\n", steel_multivariate_r_squared, steel_multivariate_r_squared_adjusted);

% Question 3 %
% Calculating and plotting residuals for the 8 models %

input("Press enter to continue to question 3...\n\n");
fprintf("Question 3\n\n");

rc_floor_area_residuals = rc_adjusted_construction_cost - rc_floor_area_construction_cost_estimation;
rc_total_floor_area_residuals = rc_adjusted_construction_cost - rc_total_floor_area_construction_cost_estimation;
rc_storey_height_residuals = rc_adjusted_construction_cost - rc_storey_height_construction_cost_estimation;
rc_multivariate_residuals = rc_adjusted_construction_cost - rc_multivariate_construction_cost_estimation;

steel_floor_area_residuals = steel_adjusted_construction_cost - steel_floor_area_construction_cost_estimation;
steel_total_floor_area_residuals = steel_adjusted_construction_cost - steel_total_floor_area_construction_cost_estimation;
steel_storey_height_residuals = steel_adjusted_construction_cost - steel_storey_height_construction_cost_estimation;
steel_multivariate_residuals = steel_adjusted_construction_cost - steel_multivariate_construction_cost_estimation;

figure(2)

% average floor area residuals %

subplot(1,4,1)
scatter(rc_adjusted_construction_cost, rc_floor_area_residuals)
hold on
scatter(steel_adjusted_construction_cost, steel_floor_area_residuals)
hold off
legend('Reinforced Concrete','Steel')
xlabel('Adjusted Construction Cost (HK$)')
ylabel('Average Floor Area Residuals')

% total floor area residuals %

subplot(1,4,2)
scatter(rc_adjusted_construction_cost, rc_total_floor_area_residuals)
hold on
scatter(steel_adjusted_construction_cost, steel_total_floor_area_residuals)
hold off
xlabel('Adjusted Construction Cost (HK$)')
ylabel('Total Floor Area Residuals')

% storey height residuals %

subplot(1,4,3)
scatter(rc_adjusted_construction_cost, rc_storey_height_residuals)
hold on
scatter(steel_adjusted_construction_cost, steel_storey_height_residuals)
hold off
xlabel('Adjusted Construction Cost (HK$)')
ylabel('Storey Height Residuals')

% average floor area residuals %

subplot(1,4,4)
scatter(rc_adjusted_construction_cost, rc_multivariate_residuals)
hold on
scatter(steel_adjusted_construction_cost, steel_multivariate_residuals)
hold off
xlabel('Adjusted Construction Cost (HK$)')
ylabel('Multivariate Model Residuals')
