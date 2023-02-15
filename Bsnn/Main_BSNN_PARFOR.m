%PARALLEL BSNN SOFTWARE-ONLY CODE

%13 Agustos 2019
%784x500x1000x10
%MNIST - sigmoid - sigmoid - softmax [cross-entropy]
clear all
close all
clc
delete(gcp('nocreate')) % shut down pool
warning('off','all')
%%                               TEST
%*****************************Preliminary**********************************
noise_type = 0; %0 -> no noise

% _-_-_-_-_-_- if noise_type ~= 0  _-_-_-_-_-_-
noise_percentage_over_pixels = 100;
noise_percentage_over_images = 50;
% _-_-_-_-_-_- if noise_type ~= 0  _-_-_-_-_-_-

no_of_hidden_layers = 2; %Static value
CPU_cores = 4;
pile_in_each_worker = 250; %2500 for full database
number_of_possible_in_TEST = pile_in_each_worker*CPU_cores;

%Quantization Parameters---------------------------------------------------
C_or_Q_or_B = 1; % 1 -> Quantization (Q_ and L_ are crucial) | 2 -> Binarization (Q_ and L_ are NOT crucial)
max_ = 1;
min_ = 0;
q = 2; %# of the bits
L_ = 2^q; %4=2^2bit | 8=2^3bit | 16=2^4bit
Q_ = (max_-min_)/L_;
%Quantization Parameters---------------------------------------------------

%--------------------------------------------------------------------------
package_size = 2 * (L_); %Relation between Built-in Quantization (Q) and package size
%package_size = 8; %Relation between Built-in Quantization (Q) and package size
%--------------------------------------------------------------------------

%getting input data stream
[test__data_BSNN, w1_BSNN, w2_BSNN, w3_BSNN, b_w] = package_ready(package_size, noise_type, number_of_possible_in_TEST, Q_, min_, max_, C_or_Q_or_B, noise_percentage_over_pixels, noise_percentage_over_images); %Stream Generation



%******************
%     number_of_degrede1HL=78400; %max 784*500 = 392000; if all bits faulty, 392000*package size; but not that random 
%     for i = 1:number_of_degrede1HL
%         if w1_BSNN(randi([1,size(w1_BSNN,1)],1),randi([1,size(w1_BSNN,2)],1),1) == 1
%             w1_BSNN(randi([1,size(w1_BSNN,1)],1),randi([1,size(w1_BSNN,2)],1),:) = 0;
%         end   
% %         if w1_BSNN(randi([1,size(w1_BSNN,1)],1),randi([1,size(w1_BSNN,2)],1),1) == 0
% %             w1_BSNN(randi([1,size(w1_BSNN,1)],1),randi([1,size(w1_BSNN,2)],1),:) = 1;
% %         end     
%     end
    
    %number_of_degrede2HL=500000; %max 500*1000 = 500000; if all bits faulty, 500000*package size; but not that random 
    counter_HL = 0;
    for i = 1:3136000
        rnd = randi([1 package_size], [1, 1]);
        if w1_BSNN(randi([1,size(w1_BSNN,1)],1),randi([1,size(w1_BSNN,2)],1),rnd) == 1 && counter_HL <= 313600
            w1_BSNN(randi([1,size(w1_BSNN,1)],1),randi([1,size(w1_BSNN,2)],1),rnd) = 0;
            counter_HL = counter_HL + 1; %randi([1 package_size], [1, 1])
        end   
%         if w2_BSNN(randi([1,size(w2_BSNN,1)],1),randi([1,size(w2_BSNN,2)],1),1) == 0
%             w2_BSNN(randi([1,size(w2_BSNN,1)],1),randi([1,size(w2_BSNN,2)],1),:) = 1;
%         end     
    end



%     %number_of_degrede2HL=500000; %max 500*1000 = 500000; if all bits faulty, 500000*package size; but not that random 
%     counter_HL = 0;
%     for i = 1:500000
%         if w2_BSNN(randi([1,size(w2_BSNN,1)],1),randi([1,size(w2_BSNN,2)],1),1) == 1 && counter_HL <= 200000
%             w2_BSNN(randi([1,size(w2_BSNN,1)],1),randi([1,size(w2_BSNN,2)],1),:) = 0;
%             counter_HL = counter_HL + 1;
%         end   
% %         if w2_BSNN(randi([1,size(w2_BSNN,1)],1),randi([1,size(w2_BSNN,2)],1),1) == 0
% %             w2_BSNN(randi([1,size(w2_BSNN,1)],1),randi([1,size(w2_BSNN,2)],1),:) = 1;
% %         end     
%     end
%     
    
    



ACCURACY = 0;
TEST_RESULTS = zeros(number_of_possible_in_TEST);
isMNIST_or_FashionMNIST = 0; %0 -> MNIST digit | 1 -> MNIST fashion
%Just for labels_test
[images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST_or_FashionMNIST);
%*****************************Preliminary**********************************

%Get Stream Weights--------------------------------------------------------
%test__data_BSNN = importdata('test__data_BSNN.mat');
% w1_BSNN = importdata('w1_BSNN.mat');
% w2_BSNN = importdata('w2_BSNN.mat');
% w3_BSNN = importdata('w3_BSNN.mat');
% b_w = importdata('b_save_9186.mat');
%Get Stream Weights--------------------------------------------------------

ACCURACY_TOTAL = 0; %Final Accuracy from workers in total

%Parallel Processing-------------------------------------------------------
parpool(CPU_cores) %I have 4-CPU cores
parfor K = 1 : CPU_cores
  Worker_ACCURACY = BSNN_Test_Worker(package_size, no_of_hidden_layers, ACCURACY, TEST_RESULTS, labels_test, test__data_BSNN, w1_BSNN, w2_BSNN, w3_BSNN, b_w, pile_in_each_worker, K);
  
  %just to see
  disp(Worker_ACCURACY)
  %Total in Total
  ACCURACY_TOTAL = ACCURACY_TOTAL + Worker_ACCURACY;
end
%Parallel Processing-------------------------------------------------------

%Asagidaki ni ilk denememde kullandým ama 1'den çok fonksiyonla uðraþmak
%zorladý, sonra tek 1 K1'e indirdim. 
% parpool(2)
% parfor K = 1 : 2
% 
%   if K == 1
%       Worker_ACCURACY = K1(package_size, no_of_hidden_layers, ACCURACY, TEST_RESULTS, labels_test);
%   end
%   if K == 2
%       Worker_ACCURACY = K2(package_size, no_of_hidden_layers, ACCURACY, TEST_RESULTS, labels_test); 
%   end
%   disp(Worker_ACCURACY)
%   ACCURACY_TOTAL = ACCURACY_TOTAL + Worker_ACCURACY;
% 
% end