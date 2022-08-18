load ('CLNR_Jan_2012.mat');

n_X = 273;
n_Y1 = 907;
n_Y2 = 908;


exitflag1 = 0;  % The following 4 exit flags are used to end the while loops containing menus %

fprintf('\n Electricity Smart Meter data \n\n'); % This is the title of the program in the command window. %

while (exitflag1 == 0)% The exit flag for the main function does not need to be reset as the main function is only required to run once. % 
        
        fprintf('1. Question 1.');
        fprintf('\n2. Question 2.');
        fprintf('\n3. EXIT.\n');
        choice = input('Please select: '); % This line of code allows the user a choice of which option they would lke to select. %
         switch (choice) % This switch is the main switch for the program %
            
            case {1}
              
                %MEANS%
                X1_data = clnr_X1(:,[2]);
                X1_mean = mean(X1_data);
                fprintf('\n X1 mean = %.4f kWh \n',X1_mean);

                X2_data = clnr_X2(:,[2]);
                X2_mean = mean(X2_data);
                fprintf('\n X2 mean = %.4f kWh \n',X2_mean);

                Y1_data = clnr_Y1(:,[2]);
                Y1_mean = mean(Y1_data);
                fprintf('\n Y1 mean = %.4f kWh \n',Y1_mean);
  
                Y2_data = clnr_Y2(:,[2]);
                Y2_mean = mean(Y2_data);
                fprintf('\n Y2 mean = %.4f kWh \n',Y2_mean);

                %STD%
                
                X1_std = std(X1_data);
                fprintf('\n X1 standard deviation = %.4f \n',X1_std);

                X2_std = std(X2_data);
                fprintf('\n X2 standard deviation = %.4f \n',X2_std);

                Y1_std = std(Y1_data);
                fprintf('\n Y1 standard deviation = %.4f \n',Y1_std);

                Y2_std = std(Y2_data);
                fprintf('\n Y2 standard deviation = %.4f \n',Y2_std);

                %95% confidence interval%
                n_std = norminv(0.975);
                
                lowerbd_X1 = X1_mean - (n_std * (X1_std/sqrt(n_X)));
                upperbd_X1 = X1_mean + (n_std * (X1_std/sqrt(n_X)));
                fprintf('\n X1 Upper Bound = %.4f kWh \n',upperbd_X1);
                fprintf('\n X1 Lower Bound = %.4f kWh \n',lowerbd_X1);

                lowerbd_X2 = X2_mean - (n_std * (X2_std/sqrt(n_X)));
                upperbd_X2 = X2_mean + (n_std * (X2_std/sqrt(n_X)));
                fprintf('\n X2 Upper Bound = %.4f kWh \n',upperbd_X2);
                fprintf('\n X2 Lower Bound = %.4f kWh \n',lowerbd_X2);
                
                lowerbd_Y1 = Y1_mean - (n_std * (Y1_std/sqrt(n_Y1)));
                upperbd_Y1 = Y1_mean + (n_std * (Y1_std/sqrt(n_Y1)));
                fprintf('\n Y1 Upper Bound = %.4f kWh \n',upperbd_Y1);
                fprintf('\n Y1 Lower Bound = %.4f kWh \n',lowerbd_Y1);

                lowerbd_Y2 = Y2_mean - (n_std * (Y2_std/sqrt(n_Y2)));
                upperbd_Y2 = Y2_mean + (n_std * (Y2_std/sqrt(n_Y2)));
                fprintf('\n Y2 Upper Bound = %.4f kWh \n',upperbd_Y2);
                fprintf('\n Y2 Lower Bound = %.4f kWh \n',lowerbd_Y2);

             case{2}
                  %histograms%
                  figure(1)
                  ax1 = subplot(2,1,1);
                  X1_data = clnr_X1(:,[2]);
                  X1_data_below_1kWh = X1_data(X1_data <= 1);
                  histogram_X1 = histogram(ax1,X1_data_below_1kWh,25);
                  title(ax1,'X1: Mosaic G at 4am');
                  ylabel(ax1,'Frequency');
                  xlabel(ax1,'Electricity Consumption (kWh)');
                  movegui(histogram_X1,'west')
                  
                  ax2 = subplot (2,1,2);
                  X2_data = clnr_X2(:,[2]);
                  X2_data_below_1kWh = X2_data(X2_data <= 1);
                  histogram_X2 = histogram(ax2,X2_data_below_1kWh,25);
                  title(ax2,'X2: Mosaic G at 10am');
                  ylabel(ax2,'Frequency');
                  xlabel(ax2,'Electricity Consumption (kWh)');
                  xlim([0,1])
                  
                  figure(2)
                  ax1 = subplot (2,1,1);
                  Y1_data = clnr_Y1(:,[2]);
                  Y1_data_below_1kWh = Y1_data(Y1_data <= 1);
                  histogram_Y1 = histogram(ax1,Y1_data_below_1kWh,90);
                  title(ax1,'Y1: Mosaic I at 4am');
                  ylabel(ax1,'Frequency');
                  xlabel(ax1,'Electricity Consumption (kWh)');
                  movegui(histogram_Y1,'east')
                  
                  ax2 = subplot (2,1,2);
                  Y2_data = clnr_Y2(:,[2]);
                  Y2_data_below_1kWh = Y2_data(Y2_data <= 1);
                  histogram_Y2 = histogram(ax2,Y2_data_below_1kWh,90);
                  title(ax2,'Y2: Mosaic I at 10am');
                  ylabel(ax2,'Frequency');
                  xlabel(ax2,'Electricity Consumption (kWh)');
                  
                  
             case{3}
                              
                            exitflag1 = 1;
                             disp('Program exited');
         end
end
  
