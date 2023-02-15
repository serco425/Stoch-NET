%10 Agustos 2019
%784x500x1000x10
%MNIST - sigmoid - sigmoid - softmax [cross-entropy]
clear all
close all
clc
warning('off','all')
%%                               TEST
%Preliminary
noise_percentage_over_pixels = 10; % 10% 20% ... par example
no_of_hidden_layers = 2;
number_of_possible_in_TEST = 10000;
ACCURACY = 0;
TEST_RESULTS = zeros(number_of_possible_in_TEST);

%Quantization Parameters
C_or_Q_or_B = 1; % 1 -> Quantization (Q_ and L_ are crucial)   |    2 -> Binarization (Q_ and L_ are NOT crucial)
max_ = 1;
min_ = 0;
q = 2; %# of the bits
L_ = 2^q; %4=2^2bit | 8=2^3bit | 16=2^4bit
Q_ = (max_-min_)/L_;

isMNIST_or_FashionMNIST = 0; %0 -> MNIST digit | 1 -> MNIST fashion
%Just for labels_test
[images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST_or_FashionMNIST);

load('C:\Users\BAP_DR\Desktop\9186\w_save9186.mat');
load('C:\Users\BAP_DR\Desktop\9186\b_save_9186.mat');
w_test = w_save;
b_w = b_save;


% [X_row, X_column, thirdDimension] = size(test__data_BSNN);
% [w1_row, w1_column, thirdDimension] = size(w1_BSNN);
% [w2_row, w2_column, thirdDimension] = size(w2_BSNN);
% [w3_row, w3_column, thirdDimension] = size(w3_BSNN);

noise_percentage_over_pixels = 10; %How many pixels to be degraded
NUM_of_degraded_pixels = ceil((784*noise_percentage_over_pixels)/100);

noise_percentage_over_images = 10; %How many images to be degraded 
NUM_of_degraded_images = ceil((10000*noise_percentage_over_images)/100);

% Test Data in Conventional Binary Representation--------------------------
% 1-time done & saved------------------------------------------------------
% test__data = importdata('test_image.txt'); %in advanced normalized  /.255
% for j = 1:10000                   % *255 is for reverting normalization  
%     test__data_BIN(j,:,:) = decimalToBinaryVector(test__data(j,:)*255);
% end
% save('test__data_BIN.mat','test__data_BIN');
%--------------------------------------------------------------------------
test__data_BIN = importdata('test__data_BIN.mat'); %Previous one is called
%--------------------------------------------------------------------------

RAND_degradedIMAGE = randperm(10000);
RAND_degradedPIX = randperm(784);

%Each Image & Each Pixel & the bit
for j = 1:NUM_of_degraded_images
    for k = 1:NUM_of_degraded_pixels
        RAND_degradedBIT = randi([1 8], [1, 1]); %From 1 to 8 random bit positions
        if test__data_BIN(RAND_degradedIMAGE(j),RAND_degradedPIX(k),RAND_degradedBIT) == 1
            bit_flip = 0;
        end
        if test__data_BIN(RAND_degradedIMAGE(j),RAND_degradedPIX(k),RAND_degradedBIT) == 0
            bit_flip = 1;
        end
        test__data_BIN(RAND_degradedIMAGE(j),RAND_degradedPIX(k),RAND_degradedBIT) = bit_flip; %FLIPPED
    end
end

% Getting back to the
% test__data_DEGRADED_DEC 10000x784 size and noisy
for j = 1:10000
    for k = 1:784
        test__data_DEGRADED_DEC(j,k) = bin2dec(num2str(test__data_BIN(j,k,:)));
    end
end




%rand_784_btwn_1_to_8 is for 784 different random number between 1 and 8
%it makes each 8-bit image pixel bit flip


%test__data is 10.000 x 784 currently and make-it-binary
%8-bit as 3D 10.000 x 784 x 8








%


% sercan = [1, 0.75, 0.5, 0.25, 0];
% [images_test_row, images_test_column] = size(sercan);
% sercan2 = stream_generator(sercan, package_size, images_test_row, images_test_column);
%sonuclarý sum yapýcaksýn ama (sum() - (paket-sum())/16)

% sercan = [1, -1, -1, 1, -1];
% [images_test_row, images_test_column] = size(sercan);
% sercan2 = bsnn_weight_generator(sercan, package_size, images_test_row, images_test_column);


b = ones(1,no_of_hidden_layers+1);

for j = 1:number_of_possible_in_TEST %possible input trials
    %FORWARD-PROPOGATING TEST SIGNALS
    for i = 1:(no_of_hidden_layers+1) % +2 is for input and the output layer
        %first weights for the input-first (hidden) layer relation / first layer output prep
        if i==1
            
            test__data_BSNN
            
            layer_wise_test_DET{1} = double(test__data(j,:))*double(cell2mat(w_test(1,1,1))) + double(b(1))*double(cell2mat(b_w(1,1,1)));
            %count 1's and threshold to decide to put 1's ones and 0'zeros
            %************************SIGMOID -> SIGN***********************
            layer_wise_test_DET_ACT{1} = sign(layer_wise_test_DET{1});
            %************************SIGMOID -> SIGN***********************
        end
        
        %first hidden layer / second layer output prep
        if i==2
            layer_wise_test_DET{2} = layer_wise_test_DET_ACT{1}*double(cell2mat(w_test(1,2,1))) + double(b(2))*double(cell2mat(b_w(1,2,1)));
            %************************SIGMOID -> SIGN***********************
            layer_wise_test_DET_ACT{2} = sign(layer_wise_test_DET{2});
            %************************SIGMOID -> SIGN***********************
        end
        
        %second hidden layer / output layer output prep
        if i==3
            layer_wise_test_DET{3} = layer_wise_test_DET_ACT{2}*double(cell2mat(w_test(1,3,1))) + double(b(3))*double(cell2mat(b_w(1,3,1)));
            %***************************SOFTMAX***************************
            layer_wise_test_DET_ACT{3} = transpose(softmax(transpose(layer_wise_test_DET{3})));
            %***************************SOFTMAX***************************
        end
    end
    
    %Accuracy calculation
    TEST_RESULTS(j) = (find(layer_wise_test_DET_ACT{no_of_hidden_layers+1} == max(layer_wise_test_DET_ACT{no_of_hidden_layers+1}(:))) -1);
    if labels_test(j) == TEST_RESULTS(j)
        ACCURACY = ACCURACY + 1;
    end
end