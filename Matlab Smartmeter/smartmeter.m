

load ('CLNR_Jan_2012.mat');

% Question 1 %

fprintf("Question 1:\n\n");

% Calculations %

% Loading all column data into arrays %
G4_consumption = clnr_X1(:,2);
G10_consumption = clnr_X2(:,2);
I4_consumption = clnr_Y1(:,2);
I10_consumption = clnr_Y2(:,2);

num_G4 = numel(G4_consumption);
num_G10 = numel(G10_consumption);
num_I4 = numel(I4_consumption);
num_I10 = numel(I10_consumption);

mean_G4 = mean(G4_consumption);
mean_G10 = mean(G10_consumption);
mean_I4 = mean(I4_consumption);
mean_I10 = mean(I10_consumption);

standard_dev_G4 = std(G4_consumption);
standard_dev_G10 = std(G10_consumption);
standard_dev_I4 = std(I4_consumption);
standard_dev_I10 = std(I10_consumption);

% Since all data sets are greater than 30, CLT can be used to calculate confidence interval %

confidence_level = norminv(0.975);

confidence_int_G4 = confidence_level*(standard_dev_G4/sqrt(num_G4));
confidence_int_G10 = confidence_level*(standard_dev_G10/sqrt(num_G10));
confidence_int_I4 = confidence_level*(standard_dev_I4/sqrt(num_I4));
confidence_int_I10 = confidence_level*(standard_dev_I10/sqrt(num_I10));

% Value output %

fprintf("Mean electricity consumptions:\n\n");
fprintf("Mosaic G at 4am:\t%fkWh\n", mean_G4);
fprintf("Mosaic G at 10am:\t%fkWh\n", mean_G10);
fprintf("Mosaic I at 4am:\t%fkWh\n", mean_I4);
fprintf("Mosaic I at 10am:\t%fkWh\n\n", mean_I10);

fprintf("Standard deviation of electricity consumptions:\n\n");
fprintf("Mosaic G at 4am:\t%f\n", standard_dev_G4);
fprintf("Mosaic G at 10am:\t%f\n", standard_dev_G10);
fprintf("Mosaic I at 4am:\t%f\n", standard_dev_I4);
fprintf("Mosaic I at 10am:\t%f\n\n", standard_dev_I10);

fprintf("Confidence levels of electricity consumptions:\n\n");
fprintf("Mosaic G at 4am:\t%f +/- %f kWh\n", mean_G4, confidence_int_G4);
fprintf("Mosaic G at 10am:\t%f +/- %fkWh\n", mean_G10, confidence_int_G10);
fprintf("Mosaic I at 4am:\t%f +/- %fkWh\n", mean_I4, confidence_int_I4);
fprintf("Mosaic I at 10am:\t%f +/- %fkWh\n\n", mean_I10, confidence_int_I10);

% Question 2 %

input("Press enter to continue to question 2...\n\n");

% Calculating the appropriate number of bins for each histogram %

num_bins_G4 = ceil(sqrt(num_G4));
num_bins_G10 = ceil(sqrt(num_G10));
num_bins_I4 = ceil(sqrt(num_I4));
num_bins_I10 = ceil(sqrt(num_I10));

fprintf("Question 2\n\n");
fprintf("Plotting histograms...\n\n");

% Plotting histograms for 4 data sets %

figure(1);

subplot(2,1,1)

G4_consumption_below_1 = G4_consumption(G4_consumption <= 1);
I4_consumption_below_1 = I4_consumption(I4_consumption <= 1);

histogram(G4_consumption_below_1, 'BinWidth', 0.05, 'Normalization','probability');
hold on
histogram(I4_consumption_below_1, 'BinWidth', 0.05, 'Normalization','probability');
hold off

title("4am");
ylabel("Probability");
xlabel("Electricity Consumption / kWh");
legend('Mosaic G', 'Mosaic I');

subplot(2,1,2)

G10_consumption_below_1 = G10_consumption(G10_consumption <= 1);
I10_consumption_below_1 = I10_consumption(I10_consumption <= 1);

histogram(G10_consumption_below_1, 'BinWidth', 0.05, 'Normalization','probability');
hold on
histogram(I10_consumption_below_1, 'BinWidth', 0.05, 'Normalization','probability');
hold off

title("10am");
ylabel("Probability");
xlabel("Electricity Consumption / kWh");
legend('Mosaic G', 'Mosaic I');

input("Press enter to continue to question 3...\n\n");

fprintf("Question 3\n\n");

% Plotting histograms with lognormal curves fitted %

figure(2);

subplot(2,1,1)

histfit(I4_consumption, num_bins_I4, 'lognormal');
ylabel('Frequency');
xlabel('Electricity Consumption / kWh');
title('Mosaic I at 4am');

subplot(2,1,2)

histfit(I10_consumption, num_bins_I10, 'lognormal');
ylabel('Frequency');
xlabel('Electricity Consumption (kWh)');
title('Mosaic I at 10am');

% Model of num customers using more than 1kWh %

I4_lognormal_model = lognfit(I4_consumption);
I10_lognormal_model = lognfit(I10_consumption);

I4_lognormal_model_mean = I4_lognormal_model(1);
I4_lognormal_model_variance = I4_lognormal_model(2);

% Extracting mean and variance from lognfit %

I10_lognormal_model_mean = I10_lognormal_model(1);
I10_lognormal_model_variance = I10_lognormal_model(2);

% Calculating z values using equation z = (log(x) - mu) / sigma %

I4_z_value = (log(1)-(I4_lognormal_model_mean))/I4_lognormal_model_variance;
I10_z_value = (log(1)-(I10_lognormal_model_mean))/I10_lognormal_model_variance;

% using normcdf to convert z value to probability and multiplying it by number of elements to arrive at a predicted value %

I4_p = normcdf(I4_z_value);
I10_p = normcdf(I10_z_value);

predicted_num_I4_above_1 = round((1 - I4_p) * num_I4);
predicted_num_I10_above_1 = round((1 - I10_p) * num_I10);

% Actual num customers using more than 1 kWh of electricity %

num_I4_above_1 = sum(I4_consumption()>1);
num_I10_above_1 = sum(I10_consumption()>1); 

fprintf("Number of customers predicted to use more than 1kWh:\n");
fprintf("4am:\t%.2f\n10am\t%.2f\n", predicted_num_I4_above_1, predicted_num_I10_above_1);

fprintf("Number of customers who actually used more than 1kWh:\n");
fprintf("4am:\t%.2f\n10am\t%.2f\n", num_I4_above_1, num_I10_above_1);


