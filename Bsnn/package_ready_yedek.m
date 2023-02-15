function package_ready(package_size, BNN_or_BSNN)
%this calls 3 functions stream_generator.m , bsnn_weight_generator.m ,
%Do_Quantization_BSNN.m

%13 Agustos 2019
%784x500x1000x10
%MNIST - sigmoid - sigmoid - softmax [cross-entropy]

%%                               TEST
%Quantization Parameters---------------------------------------------------
C_or_Q_or_B = 1; % 1 -> Quantization (Q_ and L_ are crucial)   |    2 -> Binarization (Q_ and L_ are NOT crucial)
max_ = 1;
min_ = 0;
q = 2; %# of the bits
L_ = 2^q; %4=2^2bit | 8=2^3bit | 16=2^4bit
Q_ = (max_-min_)/L_;
%Quantization Parameters---------------------------------------------------

%Test Image Stream---------------------------------------------------------
%Getting from Python-based normalized data
test__data = importdata('test_image.txt'); %in advanced normalized    /.255
%Quantize Input
test__data = Do_Quantization_BSNN(Q_, min_, max_, C_or_Q_or_B, test__data);
%Get Stochastic Input Stream
[images_test_row, images_test_column] = size(test__data);
test__data_BSNN = stream_generator(test__data, package_size, images_test_row, images_test_column);
%Test Image Stream---------------------------------------------------------

%Weights Stream------------------------------------------------------------
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
%Weights Stream------------------------------------------------------------

%Saving to be used in Parallel Simulation of BSNN--------------------------
save('test__data_BSNN.mat','test__data_BSNN');
save('w1_BSNN.mat','w1_BSNN');
save('w2_BSNN.mat','w2_BSNN');
save('w3_BSNN.mat','w3_BSNN');
%Saving to be used in Parallel Simulation of BSNN--------------------------

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