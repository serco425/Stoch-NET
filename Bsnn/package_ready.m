function [test__data_BSNN, w1_BSNN, w2_BSNN, w3_BSNN, b_w] = package_ready(package_size, noise_type, number_of_possible_in_TEST, Q_, min_, max_, C_or_Q_or_B, noise_percentage_over_pixels, noise_percentage_over_images)
%this calls 4 functions stream_generator.m , bsnn_weight_generator.m ,
%Do_Quantization_BSNN.m and Do_physical_image_noise.m if there is the noise

%17 Agustos 2019
%784x500x1000x10
%MNIST - sigmoid - sigmoid - softmax [cross-entropy]

%%                       DECISION ON THE NOISE
if noise_type == 0
    %ONLY GET DATA
    %Getting from Python-based normalized data
    test__data_withoutNoise = importdata('test_image.txt'); %in advanced normalized    /.255
    
    %if isMNIST == 5 %5 -> MNIST-C dotted_line
    % test__data_withoutNoise = double(importdata('test_images_shot_noise.txt'));
    %end
    
    
    %     isMNIST = 5; %2 -> morph. thin
    %     %re-reading
    %     [images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);
    %     test__data_withoutNoise = double(transpose(images_test))/255; %10000 x 784
    
    
    
    %COK UZUN SUREN KISIM, STREAM URETIMI
    %Daha oncekini okutmak istersen beklememek için; comment out
    %Test Image Stream-----------------------------------------------------
    %Quantize Input - BSNN - Built-in Stochastization
    test__data_Q = Do_Quantization_BSNN(Q_, min_, max_, C_or_Q_or_B, test__data_withoutNoise(1:number_of_possible_in_TEST,:));
    %Get Stochastic Input Stream
    [images_test_row, images_test_column] = size(test__data_Q);
    test__data_BSNN = stream_generator(test__data_Q, package_size, images_test_row, images_test_column);
    %Test Image Stream-----------------------------------------------------
    
    save('test__data_BSNN_8bit.mat', 'test__data_BSNN');
    
    %Daha oncekini okutmak istersen beklememek için; comment out
    %test__data_BSNN = importdata('test__data_BSNN_8bit.mat'); %Previous one is called
    
    %Weights Stream--------------------------------------------------------
    %Fine-tuned data from Matlab (which had get from pre-train though via Keras)
    w_test = importdata('w_save9186.mat'); %import yapýcaksýn
    %Conversion from cell array to double [Fine Tuning Matlab does return]
    w1_double = double(cell2mat(w_test(1,1,1)));
    w2_double = double(cell2mat(w_test(1,2,1)));
    w3_double = double(cell2mat(w_test(1,3,1)));
    
    %size issues and getting the stream from bsnn_weight_generator.m
    [w1_row, w1_column] = size(w1_double);
    w1_BSNN = bsnn_weight_generator(w1_double, package_size, w1_row, w1_column);
    
    
    %Adder compensation
    %     rand_indice = randperm(784,784);
    %     indice_counter = 0;
    %     for i = 1:784
    %         if rand_indice(i) > 100 && rand_indice(i) < 700
    %             indice(indice_counter + 1) = rand_indice(i);
    %             indice_counter = indice_counter + 1;
    %         end
    %     end
    
    
    %     counter = 0;
    %     for j=1:500
    %         counter = 0;
    %         for i=1:599
    %             if w1_BSNN(indice(i),j,1) == true && counter ~= 30
    %                 w1_BSNN(indice(i),j,:) = false;
    %                 counter = counter + 1;
    %             end
    %         end
    %     end
    
    %     counter = 0;
    %     for j=1:500
    %         counter = 0;
    %         for i=1:784
    %             if w1_BSNN(i,j,1) == true && counter ~= 120
    %                 w1_BSNN(i,j,:) = false;
    %                 counter = counter + 1;
    %             end
    %         end
    %     end
    
    [w2_row, w2_column] = size(w2_double);
    w2_BSNN = bsnn_weight_generator(w2_double, package_size, w2_row, w2_column);
    [w3_row, w3_column] = size(w3_double);
    w3_BSNN = bsnn_weight_generator(w3_double, package_size, w3_row, w3_column);
    %Weights Stream--------------------------------------------------------
    
    %----------------------------------------------------------------------
    b_w = importdata('b_save_9186.mat');
    %----------------------------------------------------------------------
    
    %Saving to be used in Parallel Simulation of BSNN----------------------
    %save('test__data_BSNN.mat','test__data_BSNN');
    %save('w1_BSNN.mat','w1_BSNN');
    %save('w2_BSNN.mat','w2_BSNN');
    %save('w3_BSNN.mat','w3_BSNN');
    %Saving to be used in Parallel Simulation of BSNN----------------------
    
end %end of noise type-0 (no noise)

if noise_type == 1 %Memory-based physical noise
    
    %Getting from Python-based normalized data
    test__data_withoutNoise = importdata('test_image.txt'); %in advanced normalized    /.255
    
    %Test Image Stream-----------------------------------------------------
    %Quantize Input - BSNN - Built-in Stochastization
    %     test__data_Q = Do_Quantization_BSNN(Q_, min_, max_, C_or_Q_or_B, test__data_withoutNoise(1:number_of_possible_in_TEST,:));
    %     %Get Stochastic Input Stream
    %     [images_test_row, images_test_column] = size(test__data_Q);
    %     DATA = stream_generator(test__data_Q, package_size, images_test_row, images_test_column);
    %     %Test Image Stream-----------------------------------------------------
    %     save('DATA_32_mnist_ref.mat', 'DATA'); %RAND_degradedPIX_tobeused_BSNN
    
    DATA = importdata('DATA_32_mnist_ref.mat');
    
    %for parameters: Do_physical_image_noise(DATA, number_of_possible_in_TEST, is_BNN, noise_percentage_over_pixels, noise_percentage_over_images, package_size)
    test__data_BSNN = Do_physical_image_noise(DATA, number_of_possible_in_TEST, 0, noise_percentage_over_pixels, noise_percentage_over_images, package_size);
    
    %Weights Stream--------------------------------------------------------
    %Fine-tuned data from Matlab (which had get from pre-train though via Keras)
    w_test = importdata('w_save9186.mat'); %import yapýcaksýn
    %Conversion from cell array to double [Fine Tuning Matlab does return]
    w1_double = double(cell2mat(w_test(1,1,1)));
    w2_double = double(cell2mat(w_test(1,2,1)));
    w3_double = double(cell2mat(w_test(1,3,1)));
    
    %size issues and getting the stream from bsnn_weight_generator.m
    [w1_row, w1_column] = size(w1_double);
    w1_BSNN = bsnn_weight_generator(w1_double, package_size, w1_row, w1_column);
    [w2_row, w2_column] = size(w2_double);
    w2_BSNN = bsnn_weight_generator(w2_double, package_size, w2_row, w2_column);
    [w3_row, w3_column] = size(w3_double);
    w3_BSNN = bsnn_weight_generator(w3_double, package_size, w3_row, w3_column);
    %Weights Stream--------------------------------------------------------
    
    %----------------------------------------------------------------------
    b_w = importdata('b_save_9186.mat');
    %----------------------------------------------------------------------
    
    %Saving to be used in Parallel Simulation of BSNN----------------------
    %save('test__data_BSNN.mat','test__data_BSNN');
    %save('w1_BSNN.mat','w1_BSNN');
    %save('w2_BSNN.mat','w2_BSNN');
    %save('w3_BSNN.mat','w3_BSNN');
    %Saving to be used in Parallel Simulation of BSNN--------------------------
    
end %end of memory-based physical noise



if noise_type == 3
    %ONLY GET DATA
    %Getting from Python-based normalized data
    test__data_withoutNoise = importdata('test_image.txt'); %in advanced normalized    /.255
    
    %COK UZUN SUREN KISIM, STREAM URETIMI
    %Daha oncekini okutmak istersen beklememek için; comment out
    %Test Image Stream-----------------------------------------------------
    %Quantize Input - BSNN - Built-in Stochastization
    test__data_Q = Do_Quantization_BSNN(Q_, min_, max_, C_or_Q_or_B, test__data_withoutNoise(1:number_of_possible_in_TEST,:));
    %Get Stochastic Input Stream
    [images_test_row, images_test_column] = size(test__data_Q);
    test__data_BSNN = stream_generator(test__data_Q, package_size, images_test_row, images_test_column);
    %Test Image Stream-----------------------------------------------------
    
    %save('test__data_BSNN_8bit.mat', 'test__data_BSNN');
    
    %Daha oncekini okutmak istersen beklememek için; comment out
    %test__data_BSNN = importdata('test__data_BSNN_8bit.mat'); %Previous one is called
    
    %Weights Stream--------------------------------------------------------
    %Fine-tuned data from Matlab (which had get from pre-train though via Keras)
    w_test = importdata('w_save9186.mat'); %import yapýcaksýn
    %Conversion from cell array to double [Fine Tuning Matlab does return]
    w1_double = double(cell2mat(w_test(1,1,1)));
    w2_double = double(cell2mat(w_test(1,2,1)));
    w3_double = double(cell2mat(w_test(1,3,1)));
    
    %size issues and getting the stream from bsnn_weight_generator.m
    [w1_row, w1_column] = size(w1_double);
    w1_BSNN = bsnn_weight_generator(w1_double, package_size, w1_row, w1_column);
    [w2_row, w2_column] = size(w2_double);
    w2_BSNN = bsnn_weight_generator(w2_double, package_size, w2_row, w2_column);
    [w3_row, w3_column] = size(w3_double);
    w3_BSNN = bsnn_weight_generator(w3_double, package_size, w3_row, w3_column);
    %Weights Stream--------------------------------------------------------
    
    %Noise Injection into weights
    %w1_column -> 1. hidden layer size
    %w2_row -> 2. hidden layer size
    
%     first_hiddenL_weight_flip_percentage = 100;
%     second_hiddenL_weight_flip_percentage = 100;
%     
%     number_of_degraded_weight_1HL = ceil((w1_column * first_hiddenL_weight_flip_percentage)/100);
%     first_HL_degrade_neuron_LIST = randperm(w1_column, number_of_degraded_weight_1HL);
%     row_on_the_back_1HL = randperm(w1_row, number_of_degraded_weight_1HL);
%     
%     number_of_degraded_weight_2HL = ceil((w2_column * second_hiddenL_weight_flip_percentage)/100);
%     second_HL_degrade_neuron_LIST = randperm(w2_column, number_of_degraded_weight_2HL);
%     row_on_the_back_2HL = randperm(w2_row, number_of_degraded_weight_1HL);
%     
%     
%     for indice = 1:number_of_degraded_weight_1HL
%         if w1_BSNN(row_on_the_back_1HL(indice),first_HL_degrade_neuron_LIST(indice),1) == 1
%             w1_BSNN(row_on_the_back_1HL(indice),first_HL_degrade_neuron_LIST(indice),:) = 0;
%         end
%         if w1_BSNN(row_on_the_back_1HL(indice),first_HL_degrade_neuron_LIST(indice),1) == 0
%             w1_BSNN(row_on_the_back_1HL(indice),first_HL_degrade_neuron_LIST(indice),randi([1 package_size], [1, 1])) = 1;
%         end
%     end
    
    w1_BSNN = w1_BSNN;
    
%    for indice = 1:number_of_degraded_weight_2HL
%         if w2_BSNN(row_on_the_back_2HL(ceil(indice/2)),second_HL_degrade_neuron_LIST(indice),1) == 1
%             w2_BSNN(row_on_the_back_2HL(ceil(indice/2)),second_HL_degrade_neuron_LIST(indice),randi([1 package_size], [1, 1])) = 0;
%         end
% %         if w2_BSNN(row_on_the_back_2HL(ceil(indice/2)),second_HL_degrade_neuron_LIST(indice),1) == 0
% %             w2_BSNN(row_on_the_back_2HL(ceil(indice/2)),second_HL_degrade_neuron_LIST(indice),randi([1 package_size], [1, 1])) = 1;
% %         end
%    end
        
   w2_BSNN = w2_BSNN; 
   
    %----------------------------------------------------------------------
    b_w = importdata('b_save_9186.mat');
    %----------------------------------------------------------------------
    
    %Saving to be used in Parallel Simulation of BSNN----------------------
    %save('test__data_BSNN.mat','test__data_BSNN');
    %save('w1_BSNN.mat','w1_BSNN');
    %save('w2_BSNN.mat','w2_BSNN');
    %save('w3_BSNN.mat','w3_BSNN');
    %Saving to be used in Parallel Simulation of BSNN----------------------
    
end %end of noise type-3 - weight-flipping

%Misc. for me :) (well I am just controlling how I code badly :P )
%--------------------------------------------------------------------------
%Data ureteci kontrolu
% sercan = [1, 0.75, 0.5, 0.25, 0];
% [images_test_row, images_test_column] = size(sercan);
% sercan2 = stream_generator(sercan, package_size, images_test_row, images_test_column);
%sonuclarý sum yapýcaksýn ama (sum() - (paket-sum())/16)

%Weight üreteci kontrolü
% sercan = [1, -1, -1, 1, -1];
% [images_test_row, images_test_column] = size(sercan);
% sercan2 = bsnn_weight_generator(sercan, package_size, images_test_row, images_test_column);
%--------------------------------------------------------------------------

end %voila! C'est fini!