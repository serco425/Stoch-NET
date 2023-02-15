%PARALLEL BNN SOFTWARE-ONLY CODE

%13 Agustos 2019
%784x500x1000x10
%MNIST - sigmoid - sigmoid - softmax [cross-entropy]
clear all
close all
clc
warning('off','all')
%%                               TEST
%*****************************Preliminary**********************************
noise_type = 0; %0 -> no noise | 1 -> physical mem. noise | 2 -> morph. thin | 3 -> morph. thick

% _-_-_-_-_-_- if noise_type == 1  _-_-_-_-_-_-
noise_percentage_over_pixels = 100;
noise_percentage_over_images = 20;
% _-_-_-_-_-_- if noise_type == 1  _-_-_-_-_-_-

no_of_hidden_layers = 2; %Static value
number_of_possible_in_TEST = 10000;

%--------------------------------------------------------------------------
load('C:\Users\BAP_DR\Desktop\9186\w_save9186.mat');
load('C:\Users\BAP_DR\Desktop\9186\b_save_9186.mat');
w_test = w_save;
b_w = b_save;
%If there is a noise, it will be overridden
test__data = (importdata('test_image.txt')); %10000 x 784 and in advanced normalized /.255
%No Quantization
%--------------------------------------------------------------------------

%imshow(reshape(uint8(test__data(31,:)*255),[28,28]))

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
    %test__data = (double(transpose(images_test)))/255; %10000 x 784
    test__data = (double(images_test)/255);
    %imshow(reshape(uint8(test__data(31,:)*255),[28,28]))
    
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

if noise_type == 3 %3 -> MNIST-C brightness
    test__data = double(importdata('test_images_brightness.txt'));
end

if noise_type == 4 %4 -> MNIST-C canny_edges
    test__data = double(importdata('test_images_canny_edges.txt'));
end

if noise_type == 5 %5 -> MNIST-C dotted_line
    test__data = double(importdata('test_images_dotted_line.txt'));
end

if noise_type == 6 %6 -> MNIST-C fog
    test__data = double(importdata('test_images_fog.txt'));
end

if noise_type == 7 %7 -> MNIST-C glass_blur
    test__data = double(importdata('test_images_glass_blur.txt'));
end

if noise_type == 8 %8 -> MNIST-C impulse_noise
    test__data = double(importdata('test_images_impulse_noise.txt'));
end

if noise_type == 9 %9 -> MNIST-C motion_blur
    test__data = double(importdata('test_images_motion_blur.txt'));
end

if noise_type == 10 %10 -> MNIST-C rotate
    test__data = double(importdata('test_images_rotate.txt'));
end

if noise_type == 11 %11 -> MNIST-C scale
    test__data = double(importdata('test_images_scale.txt'));
end

if noise_type == 12 %12 -> MNIST-C shear
    test__data = double(importdata('test_images_shear.txt'));
end

if noise_type == 13 %13 -> MNIST-C shot_noise
    test__data = double(importdata('test_images_shot_noise.txt'));
end

if noise_type == 14 %14 -> MNIST-C spatter
    test__data = double(importdata('test_images_spatter.txt'));
end

if noise_type == 15 %15 -> MNIST-C stripe
    test__data = double(importdata('test_images_stripe.txt'));
end

if noise_type == 16 %16 -> MNIST-C translate
    test__data = double(importdata('test_images_translate.txt'));
end

if noise_type == 17 %17 -> MNIST-C zigzag
    test__data = double(importdata('test_images_zigzag.txt'));
end

%*****leftover*************************************************************
if noise_type == 18 %18 -> MNIST-C contrast
    test__data = double(importdata('test_images_contrast.txt'));
end

if noise_type == 19 %19 -> MNIST-C defocus_blur
    test__data = double(importdata('test_images_defocus_blur.txt'));
end

if noise_type == 20 %20 -> MNIST-C elastic_transform
    test__data = double(importdata('test_images_elastic_transform.txt'));
end

if noise_type == 21 %21 -> MNIST-C frost
    test__data = double(importdata('test_images_frost.txt'));
end

if noise_type == 22 %22 -> MNIST-C gaussian_blur
    test__data = double(importdata('test_images_gaussian_blur.txt'));
end

if noise_type == 23 %23 -> MNIST-C gaussian_noise
    test__data = double(importdata('test_images_gaussian_noise.txt'));
end

if noise_type == 24 %24 -> MNIST-C inverse
    test__data = double(importdata('test_images_inverse.txt'));
end

if noise_type == 25 %25 -> MNIST-C jpeg_compression
    test__data = double(importdata('test_images_jpeg_compression.txt'));
end

if noise_type == 26 %26 -> MNIST-C line
    test__data = double(importdata('test_images_line.txt'));
end

if noise_type == 27 %27 -> MNIST-C pessimal_noise
    test__data = double(importdata('test_images_pessimal_noise.txt'));
end

if noise_type == 28 %28 -> MNIST-C pixelate
    test__data = double(importdata('test_images_pixelate.txt'));
end

if noise_type == 29 %29 -> MNIST-C quantize
    test__data = double(importdata('test_images_quantize.txt'));
end

if noise_type == 30 %30 -> MNIST-C saturate
    test__data = double(importdata('test_images_saturate.txt'));
end

if noise_type == 31 %31 -> MNIST-C snow
    test__data = double(importdata('test_images_snow.txt'));
end

if noise_type == 32 %32 -> MNIST-C speckle_noise
    test__data = double(importdata('test_images_speckle_noise.txt'));
end

if noise_type == 33 %33 -> MNIST-C zoom_blur
    test__data = double(importdata('test_images_zoom_blur.txt'));
end









if noise_type == 377
    isMNIST = 3; %3 -> morph. thick
    %re-reading
    [images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);
    %test__data = (double(transpose(images_test)))/255; %10000 x 784
    test__data = transpose(double(images_test)/255);
    imshow(reshape(uint8(test__data(31,:)*255),[28,28]))
end



if noise_type == 55
    isMNIST = 5; %5 -> morph. swel
    %re-reading
    [images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);
    test__data = (double(transpose(images_test))); %10000 x 784
end

if noise_type == 65 %6 -> MNIST-C 
    isMNIST = 6; 
    %re-reading
    %test_images_identity_again = importdata('test_images_identity_again.txt');
    %test__data_read = double(importdata('test_images_identity_again.mat'));

    test__data = double(importdata('test_images_quantize_again.txt')); %10000 x 784
    
    %imshow(reshape(uint8(test__data2(31,:)*255),[28,28]))
    % imshow(reshape(uint8(test__data(31,:)*255),[28,28]))

end

if noise_type == 75 %7 -> MNIST-C 
    test__data = double(importdata('test_images_shear.txt'));
    %imshow(reshape(uint8(test__data(31,:)*255),[28,28]))
end

b = ones(1,no_of_hidden_layers+1);

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
