%PARALLEL BNN SOFTWARE-ONLY CODE

%13 Agustos 2019
%784x500x1000x10
%MNIST - sigmoid - sigmoid - softmax [cross-entropy]
% clear all
% close all
% clc
warning('off','all')
%%                               TEST
%*****************************Preliminary**********************************
noise_type = 1; %0 -> no noise | 1 -> physical mem. noise | 2 -> morph. thin | 3 -> morph. thick

% _-_-_-_-_-_- if noise_type == 1  _-_-_-_-_-_-
noise_percentage_over_pixels = 100;
noise_percentage_over_images = 100;
% _-_-_-_-_-_- if noise_type == 1  _-_-_-_-_-_-

no_of_hidden_layers = 2; %Static value
number_of_possible_in_TEST = 10000;

%--------------------------------------------------------------------------
load('C:\Users\BAP_DR\Desktop\9186\w_save9186.mat');
load('C:\Users\BAP_DR\Desktop\9186\b_save_9186.mat');
w_test = w_save;
b_w = b_save;
test__data = (importdata('test_image.txt')); %10000 x 784 and in advanced normalized /.255
%No Quantization
%--------------------------------------------------------------------------

ACCURACY = 0;
TEST_RESULTS = zeros(number_of_possible_in_TEST);
isMNIST = 0; %0 -> MNIST digit | 1 -> MNIST fashion | 2 -> MNIST morph. thin
%Just for labels_test
[images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);
%*****************************Preliminary**********************************

if noise_type == 1
    test__data = Do_physical_image_noise(1989, number_of_possible_in_TEST, 1, noise_percentage_over_pixels, noise_percentage_over_images, 1989);
end

if noise_type == 2
    isMNIST = 2; %2 -> morph. thin
    %re-reading
    [images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);
    test__data = (double(transpose(images_test)))/255; %10000 x 784
    
    
%     br = fliplr(br);
%     br = importdata('test_images_brightness.txt');
%     figure
%     for i = 1:100
%         subplot(10,10,i)
%         digit = transpose(reshape(uint8(br(i, :)), [28,28]));
%         imshow(digit)
%         title(num2str(1))
%     end
    
end

if noise_type == 3
    isMNIST = 3; %3 -> morph. thick
    %re-reading
    [images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);
    test__data = (double(transpose(images_test)))/255; %10000 x 784
end



if noise_type == 5
    isMNIST = 5; %5 -> morph. swel
    %re-reading
    [images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);
    test__data = (double(transpose(images_test))); %10000 x 784
end

b = ones(1,no_of_hidden_layers+1);



    w1_double = double(cell2mat(w_test(1,1,1)));
    w2_double = double(cell2mat(w_test(1,2,1)));
    w3_double = double(cell2mat(w_test(1,3,1)));





for j = 1:number_of_possible_in_TEST %possible input trials
    %FORWARD-PROPOGATING TEST SIGNALS
    for i = 1:(no_of_hidden_layers+1) % +2 is for input and the output layer
        %first weights for the input-first (hidden) layer relation / first layer output prep
        if i==1
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
