%BNN vs. BSNN Graph - Noise 1
x = -pi:pi/10:pi;
y = tan(sin(x)) - sin(tan(x));
plot(x,y,'--gs','LineWidth',1,...
                'MarkerEdgeColor','g',...
                'MarkerFaceColor','g',...
                'MarkerSize',5)
            
hold on

x = -pi:pi/10:pi;
y = tan(0.4*sin(x)) - sin(tan(x));
plot(x,y,'-ko','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',5)
            
hold on

x = -pi:pi/10:pi;
y = tan(0.7*sin(x)) - sin(tan(x));
plot(x,y,'-.md','LineWidth',1,...
                'MarkerEdgeColor','m',...
                'MarkerFaceColor','m',...
                'MarkerSize',5)
            
hold on

x = -pi:pi/10:pi;
y = tan(0.3*sin(x)) - sin(tan(x));
plot(x,y,':rx','LineWidth',1,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',5)
            
            
            
            
            
            %define variables
SP = rand(41,1)/100;
plot(SP,'DisplayName','SP');
hold off;
title('SP and YP monthly returns');
%This is x-axis with creating a string of 196x1 dimensions
xlabel('Monthly time series');
            
                       
xTicks=1:1:41;            % EDITED 
                           % number of xticklabel control by xticks variable
set(gca,'xTick',xTicks);   % EDITED

Noise_abbraviation = ['AFF'; 'BRI'; 'CNE'; 'CON'; 'DFB'; 'DOL'; 'ELT'; 'FOG'; 'FRA'; 'FRO'; 'GLB'; 'GSB'; 'GSN'; 'IDE'; 'IMB'; 'IMN'; 'INV'; 'JPC'; 'LIN'; 'MTB'; 'PIX'; 'PSN'; 'QUA'; 'RAB'; 'RIB'; 'R-1'; 'R-2'; 'SAT'; 'SCA'; 'SHE'; 'SHN'; 'SNW'; 'SPN'; 'SPT'; 'STR'; 'SWE'; 'THC'; 'THN'; 'TRN'; 'ZOB'; 'ZZG'];
set(gca, 'xTickLabels', Noise_abbraviation);
rotateXLabels(gca,90); %for using this command you must download it or if % 
                       %your matlab version is 2015 or higher you have this 
                       %function in your toolbox
grid on
















%BNN vs. BSNN Graph - Noise 1
y = [89.3 , 85.8, 92.6, 83.6, 85.5, 86.7, 85.7, 83.6, 85.5, 86.7];
plot(y,'DisplayName','y', '--gs','LineWidth',1,...
                'MarkerEdgeColor','g',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);
            
            
            

hold off;
            
            
hold on

x = -pi:pi/10:pi;
y = tan(0.4*sin(x)) - sin(tan(x));
plot(x,y,'-ko','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',5)
            
hold on

x = -pi:pi/10:pi;
y = tan(0.7*sin(x)) - sin(tan(x));
plot(x,y,'-.md','LineWidth',1,...
                'MarkerEdgeColor','m',...
                'MarkerFaceColor','m',...
                'MarkerSize',5)
            
hold on

x = -pi:pi/10:pi;
y = tan(0.3*sin(x)) - sin(tan(x));
plot(x,y,':rx','LineWidth',1,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',5)
            
SP = [89.3 , 85.8, 92.6, 83.6, 85.5, 86.7, 85.7, 83.6, 85.5, 86.7];
plot(SP,'DisplayName','SP');
hold off;
title('Performance of BSNN on Different Image Corruptions');
xlabel('Corruption on the Image D = Database Percentage & P =');
ylabel('Accuracy (%)');      
                       



xTicks=1:1:10;
set(gca,'xTick',xTicks);   
%Noise_abbraviation = ['   no noise'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20'];
Noise_abbraviation = ['       no noise', '  50% P , 20% D', '  50% P , 50% D', ' 50% P , 100% D', '  70% P , 20% D', '  70% P , 50% D', ' 70% P , 100% D', ' 100% P , 20% D', ' 100% P , 50% D', '100% P , 100% D'];
set(gca, 'xTickLabels', Noise_abbraviation);
rotateXLabels(gca,90); %download: https://nl.mathworks.com/matlabcentral/fileexchange/27812-rotatexlabels-ax-angle-varargin

grid on














%**************************************************************************
% Sunum oncesi hazýrladýðýn, bunu kullan
%BNN vs. BSNN Graph - Noise 1

y = [91.52, 91.5, 89.5, 87.0, 89.7, 88.1, 83.6, 89.5, 85.6, 81.9]; % 8-Bit
plot(y,'--gs','LineWidth',1,...
                'MarkerEdgeColor','g',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);       
hold on
y = [91.53, 91.5, 91.7, 90.5, 91.2, 90.6, 89.7, 90.8, 90.3, 89.3]; % 16-Bit
plot(y,'-ko','LineWidth',1,...
                'MarkerEdgeColor','k',...
                'MarkerFaceColor','k',...
                'MarkerSize',5)
hold on
y = [91.6, 91.5, 91.8, 91.2, 91.9, 90.9, 91.0, 91.5, 91.0, 91.2]; % 32-Bit
plot(y,'-.md','LineWidth',1,...
                'MarkerEdgeColor','m',...
                'MarkerFaceColor','m',...
                'MarkerSize',5)    
hold on
y = [91.86, 89.88, 87.01, 81.72, 87.89, 82.03, 72.20, 85.42, 75.49, 58.58]; % REF. BNN
plot(y,':rx','LineWidth',1,...
                'MarkerEdgeColor','r',...
                'MarkerFaceColor','r',...
                'MarkerSize',5)

legend('8-bit BSNN','16-bit BSNN', '32-bit BSNN', 'Conventional BNN')
            
hold off;

title('Performance of BSNN on Different MNIST Image Corruptions Compared to BNN');
xlabel('Corruption percentage on the database = D, Corruption percentage over pixels per image P');
ylabel('Accuracy (%)');      
                       
xTicks=1:1:10;
set(gca,'xTick',xTicks);   
Noise_abbraviation = ['       no noise'; '  50% P , 20% D'; '  50% P , 50% D'; ' 50% P , 100% D'; '  70% P , 20% D'; '  70% P , 50% D'; ' 70% P , 100% D'; ' 100% P , 20% D'; ' 100% P , 50% D'; '100% P , 100% D'];
%Noise_abbraviation = ['   no noise'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20'];
set(gca, 'xTickLabels', Noise_abbraviation);
rotateXLabels(gca,90); %download: https://nl.mathworks.com/matlabcentral/fileexchange/27812-rotatexlabels-ax-angle-varargin
grid on
%**************************************************************************








%Weight noise
%**************************************************************************
% Sunum oncesi hazýrladýðýn, bunu kullan
%BNN vs. BSNN Graph - Noise 1

x = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20];
y = [91.79, 91.78, 91.46, 91.04, 90.40, 89.68, 88.28, 87.52, 83.63, 81.84, 81.21, 73.86, 68.94, 67.41, 57.93, 55.10, 48.45, 46.67, 43.29, 34.37]; % 8-Bit
plot(x,y,'--gs','LineWidth',1,...
                'MarkerEdgeColor','g',...
                'MarkerFaceColor','g',...
                'MarkerSize',5);       


title('1->0 Bit-flips on the first layer weights - Conventional BNN');
xlabel('Bit-flip Percentage (%)');
ylabel('Accuracy (%)');     
grid on
                       
xTicks=1:1:10;
set(gca,'xTick',xTicks);   
Noise_abbraviation = ['       no noise'; '  50% P , 20% D'; '  50% P , 50% D'; ' 50% P , 100% D'; '  70% P , 20% D'; '  70% P , 50% D'; ' 70% P , 100% D'; ' 100% P , 20% D'; ' 100% P , 50% D'; '100% P , 100% D'];
%Noise_abbraviation = ['   no noise'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20'; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20' ; 'D=10 & P=20'];
set(gca, 'xTickLabels', Noise_abbraviation);
rotateXLabels(gca,90); %download: https://nl.mathworks.com/matlabcentral/fileexchange/27812-rotatexlabels-ax-angle-varargin
grid on
%**************************************************************************










































% 
% 
% 
% % Create some plotting data and plot
% x = 0:0.1:2*pi;   y = sin(x);
% % Plot, can specify line attributes (like LineWidth) either 
% % - inline: plot(x,y,'linewidth',2)
% % - after: p1 = plot(x,y); p1.LineWidth = 2;
% plot(x,y);
% % Get current axes object (just plotted on) and its position
% ax1 = gca;
% axPos = ax1.Position;
% % Change the position of ax1 to make room for extra axes
% % format is [left bottom width height], so moving up and making shorter here...
% ax1.Position = axPos + [0 0.3 0 -0.3];
% % Exactly the same as for plots (above), axes LineWidth can be changed inline or after
% ax1.LineWidth = 1;
% % Add two more axes objects, with small multiplier for height, and offset for bottom
% ax2 = axes('position', (axPos .* [1 1 1 1e-3]) + [0 0.15 0 0], 'color', 'none', 'linewidth', 1);
% ax3 = axes('position', (axPos .* [1 1 1 1e-3]) + [0 0.00 0 0], 'color', 'none', 'linewidth', 1);
% % You can change the limits of the new axes using XLim
% ax2.XLim = [0 100];
% ax3.XLim = [0 100];
% % You can label the axes using XLabel.String
% ax1.XLabel.String = 'PIX';
% ax2.XLabel.String = 'DB';
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
