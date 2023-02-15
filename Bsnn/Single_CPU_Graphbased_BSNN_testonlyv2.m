%12 Agustos 2019
%784x500x1000x10
%MNIST - sigmoid - sigmoid - softmax [cross-entropy]
clear all
close all
clc
warning('off','all')
%%                               TEST
profile on
%Preliminary
% multiplied1 = zeros(1, 784, 16);
% multiplied2 = zeros(1,500,16);
% multiplied3 = zeros(1,1000,16);
% to_be_Acc1 = zeros(1, 500);
% to_be_Acc2 = zeros(1, 1000);
% to_be_Acc3 = zeros(1, 10);
% layer_wise1 = zeros(1, 500, 16);
% layer_wise2 = zeros(1, 1000, 16);

tic
package_size = 16;
no_of_hidden_layers = 2;
number_of_possible_in_TEST = 100;
ACCURACY = 0;
TEST_RESULTS = zeros(number_of_possible_in_TEST);

isMNIST_or_FashionMNIST = 0; %0 -> MNIST digit | 1 -> MNIST fashion
%Just for labels_test
[images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST_or_FashionMNIST);

load('C:\Users\BAP_DR\Desktop\test_images_16_bit_BSNN.mat')
load('C:\Users\BAP_DR\Desktop\w1_BSNN.mat')
load('C:\Users\BAP_DR\Desktop\w2_BSNN.mat')
load('C:\Users\BAP_DR\Desktop\w3_BSNN.mat')

load('C:\Users\BAP_DR\Desktop\9186\b_save_9186.mat');
b_w = b_save;

[X_row, X_column, ~] = size(test__data_BSNN);
[w1_row, w1_column, ~] = size(w1_BSNN);
[w2_row, w2_column, ~] = size(w2_BSNN);
[w3_row, w3_column, ~] = size(w3_BSNN);

%PRE-ALLOCATION
% multiplied1 = zeros(1, X_column, package_size);
% multiplied2 = zeros(1,w1_column,package_size);
% multiplied3 = zeros(1,w2_column,package_size);
% to_be_Acc1 = zeros(1, w1_column);
% to_be_Acc2 = zeros(1, w2_column);
% to_be_Acc3 = zeros(1, w3_column);
% layer_wise1 = zeros(1, w1_column, package_size);
% layer_wise2 = zeros(1, w2_column, package_size);

%b = ones(1,no_of_hidden_layers+1);

for j = 1:number_of_possible_in_TEST %possible input trials
    %FORWARD-PROPOGATING TEST SIGNALS
    for i = 1:(no_of_hidden_layers+1) % +2 is for input and the output layer
        %first weights for the input-first (hidden) layer relation / first layer output prep
        if i==1
            threshold1 = (784*package_size)/2;
            for second_layer_size = 1:w1_column %500 - in every hidden layer neuron 784 mul&acc will be done as in the following loop
                for first_layer_size = 1:X_column %784
                    input_MAC = test__data_BSNN(j,first_layer_size,:); %jth image, each 784 pixel (in neuron), every package - 2, 4, 8, 16, ... bit
                    weight_MAC = w1_BSNN(first_layer_size,second_layer_size,:);
                    
                    %MUL
                    multiplied1(1,first_layer_size,:) = ~(xor(input_MAC, weight_MAC));
                end
                
                tempSum = sum(multiplied1(1,:,:));
                
                to_be_Acc1(second_layer_size) = sum(tempSum(1,1,:));
                
            end
            
            Acc1 = to_be_Acc1 + double(cell2mat(b_w(1,1,1)));
            
            for second_layer_size = 1:w1_column %500
                
                if Acc1(second_layer_size) >= threshold1 %+1
                    layer_wise1(1, second_layer_size, 1:package_size) = true;
                end
                
                if Acc1(second_layer_size) < threshold1 %-1
                    layer_wise1(1, second_layer_size, 1:package_size) = false;
                end
            end
            
        end
        
        %first hidden layer / second layer output prep
        if i==2
            threshold2 = (500*package_size)/2;
            for third_layer_size = 1:w2_column %1000 - in every hidden layer neuron 784 mul&acc will be done as in the following loop
                for second_layer_size = 1:w1_column %500
                    input_MAC2 = layer_wise1(1,second_layer_size,:); %jth image, each 784 pixel (in neuron), every package - 2, 4, 8, 16, ... bit
                    weight_MAC2 = w2_BSNN(second_layer_size,third_layer_size,:);
                    
                    %MUL
                    multiplied2(1,second_layer_size,:) = ~(xor(input_MAC2, weight_MAC2));
                end
                
                tempSum2 = sum(multiplied2(1,:,:));
                
                to_be_Acc2(third_layer_size) = sum(tempSum2(1,1,:));
                
            end
            
            Acc2 = to_be_Acc2 + double(cell2mat(b_w(1,2,1)));
            
            for third_layer_size = 1:w2_column %1000
                
                if Acc2(third_layer_size) >= threshold2 %+1
                    layer_wise2(1, third_layer_size, 1:package_size) = true;
                end
                
                if Acc2(third_layer_size) < threshold2 %-1
                    layer_wise2(1, third_layer_size, 1:package_size) = false;
                end
            end
            
        end
        
        %second hidden layer / output layer output prep
        if i==3
            %No need threshold
            for last_layer_size = 1:w3_column %10 - in every hidden layer neuron 1000 mul&acc will be done as in the following loop
                for third_layer_size = 1:w2_column %1000
                    input_MAC3 = layer_wise2(1,third_layer_size,:); %jth image, each 784 pixel (in neuron), every package - 2, 4, 8, 16, ... bit
                    weight_MAC3 = w3_BSNN(third_layer_size,last_layer_size,:);
                    
                    %MUL
                    multiplied3(1,third_layer_size,:) = ~(xor(input_MAC3, weight_MAC3));
                end
                
                tempSum3 = sum(multiplied3(1,:,:));
                
                to_be_Acc3(last_layer_size) = sum(tempSum3(1,1,:));
                                
            end
            
            Acc3 = to_be_Acc3 + double(cell2mat(b_w(1,3,1)));
            
            for last_layer_size = 1:w3_column %10
                layer_wise_LAST{1} = transpose(softmax(transpose(Acc3))); %SOFTMAX
            end
        end %end of last layer
        
    end % end of hidden layer counter
    
    %Accuracy calculation
    TEST_RESULTS(j) = (find(layer_wise_LAST{1} == max(layer_wise_LAST{1}(:))) -1);
    if labels_test(j) == TEST_RESULTS(j)
        ACCURACY = ACCURACY + 1;
        %ACCURACY PLOT
        hold on
        plot(j,ACCURACY,'-s','MarkerSize',10,...
            'MarkerEdgeColor','red',...
            'MarkerFaceColor',[1 .6 .6])
        xlabel("nth Image over 10.000 Test Images")
        ylabel("mth Correctly Classified Image over n Images")
        grid on
        title("Accuracy for each Test Image")
        pause(0.005)
    end
    
    if labels_test(j)~= TEST_RESULTS(j)
        %No ACCURACY increment action
        %ACCURACY PLOT
        hold on
        plot(j,ACCURACY,'-s','MarkerSize',10,...
            'MarkerEdgeColor','black',...
            'MarkerFaceColor',[0 0 0])
        xlabel("nth Image over 10.000 Test Images")
        ylabel("mth Correctly Classified Image over n Images")
        grid on
        title("Accuracy for each Test Image")
        pause(0.005)
    end

end

toc