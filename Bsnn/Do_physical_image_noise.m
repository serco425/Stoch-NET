%DATA and package_size is only for BSNN
function test__data_DEGRADED_DEC_or_SC = Do_physical_image_noise(DATA, number_of_possible_in_TEST, is_BNN, noise_percentage_over_pixels, noise_percentage_over_images, package_size)

image_size = 784;
db_size = number_of_possible_in_TEST;

%DATA = is anything for BNN case 
%BNN-case------------------------------------------------------------------
if is_BNN == 1
    
    %noise_percentage_over_pixels = 20; %How many pixels to be degraded 10% 20% ... par example
    NUM_of_degraded_pixels = ceil((image_size*noise_percentage_over_pixels)/100);
    
    %noise_percentage_over_images = 10; %How many images to be degraded
    NUM_of_degraded_images = ceil((db_size*noise_percentage_over_images)/100);
    
    %**********************************************************************
    %CONVENTIONAL BINARY | Uzun hesap, 8-bit Imajlar, aþagýda
    %test__data_BIN, olarak önceden kaydettiðini oku zaten hep ayný kalýyor
    
    % Test Data in Conventional Binary Representation----------------------
    % 1-time done & saved--------------------------------------------------
    
    % test__data = importdata('test_image.txt'); %in advanced normalized  /.255
    % for j = 1:db_size                   % *255 is for reverting normalization
    %     test__data_BIN(j,:,:) = decimalToBinaryVector(test__data(j,:)*255);
    % end
    % save('test__data_BIN.mat','test__data_BIN');
    %**********************************************************************

    %Previously done static test data in 8-bit binary
    %----------------------------------------------------------------------
    test__data_BIN = importdata('test__data_BIN.mat'); %Previous one is called
    %----------------------------------------------------------------------
    
    %----------------------------------------------------------------------
    %RANDOM IMAGE ON DB AND PIXELS ON THE IMAGES ARE DECIDED HERE & SAVED
    %For BSNN after this first run the same random images and pixels will
    %be used during the tests. So run both for 1 and 2 = is_BNN
    
    %Random Images   ----->>>> a. in the figure of the journal
    RAND_degradedIMAGE = randperm(db_size,NUM_of_degraded_images);
    save('RAND_degradedIMAGE.mat', 'RAND_degradedIMAGE'); %RAND_degradedIMAGE_tobeused_BSNN
    
    %Random Pixels   ----->>>> b. in the figure of the journal
    for j = 1:NUM_of_degraded_images
        RAND_degradedPIX(j,1:NUM_of_degraded_pixels) = randperm(image_size,NUM_of_degraded_pixels);
    end
    save('RAND_degradedPIX.mat', 'RAND_degradedPIX'); %RAND_degradedPIX_tobeused_BSNN
    %----------------------------------------------------------------------
    
    test__data_DEGRADED_BIN = test__data_BIN; %Just copy first to degrade afterall
    
    %Each Image & Each Pixel & the bit
    for j = 1:NUM_of_degraded_images
        for k = 1:NUM_of_degraded_pixels
            RAND_degradedBIT = randi([1 8], [1, 1]); %From 1 to 8 random bit positions %Random Bits ----->>>> c. in the figure of the journal
            if test__data_BIN(RAND_degradedIMAGE(j),RAND_degradedPIX(j,k),RAND_degradedBIT) == 1
                bit_flip = 0;
            end
            if test__data_BIN(RAND_degradedIMAGE(j),RAND_degradedPIX(j,k),RAND_degradedBIT) == 0
                bit_flip = 1;
            end
            test__data_DEGRADED_BIN(RAND_degradedIMAGE(j),RAND_degradedPIX(j,k),RAND_degradedBIT) = bit_flip; %FLIPPED
        end
    end
    
    % Getting back to the decimal case
    % test__data_DEGRADED_DEC_or_SC 10000x784 size and noisy
    for j = 1:db_size
        for k = 1:image_size
            test__data_DEGRADED_DEC_or_SC(j,k) = bin2dec(num2str(test__data_DEGRADED_BIN(j,k,:)));
        end
    end
    
    %FINAL_SAVE
    save('test__data_DEGRADED_DEC.mat', 'test__data_DEGRADED_DEC_or_SC');
    
end %end of BNN-case
%--------------------------------------------------------------------------


%DATA = SC stream of the test images
%BSNN-case-----------------------------------------------------------------
if is_BNN == 0
    NUM_of_degraded_pixels = ceil((image_size*noise_percentage_over_pixels)/100);
    NUM_of_degraded_images = ceil((db_size*noise_percentage_over_images)/100);
        
    %FOR THE SAME NOISE INDICES ON DB AND PIX****************************** 
%     %whichever images on the DB was degraded on BNN, use them to be comparable
%     RAND_degradedIMAGE_tobeused_BSNN = importdata('RAND_degradedIMAGE.mat');
%     
%     %whichever pixels (for each image) on the DB was degraded on BNN
%     RAND_degradedPIX_tobeused_BSNN = importdata('RAND_degradedPIX.mat');
    %FOR THE SAME NOISE INDICES ON DB AND PIX****************************** 


    %Random Images   ----->>>> a. in the figure of the journal
    RAND_degradedIMAGE_tobeused_BSNN = randperm(db_size,NUM_of_degraded_images);
    
    %Random Pixels   ----->>>> b. in the figure of the journal
    for j = 1:NUM_of_degraded_images
        RAND_degradedPIX_tobeused_BSNN(j,1:NUM_of_degraded_pixels) = randperm(image_size,NUM_of_degraded_pixels);
    end
    
    test__data_DEGRADED_SC = DATA; %Just copy first to degrade afterall
    
    %Each Image & Each Pixel & the bit
    for j = 1:NUM_of_degraded_images
        for k = 1:NUM_of_degraded_pixels
            RAND_degradedBIT = randi([1 package_size], [1, 1]); %From 1 to 'package_size' random bit positions
            if DATA(RAND_degradedIMAGE_tobeused_BSNN(j),RAND_degradedPIX_tobeused_BSNN(j,k),RAND_degradedBIT) == 1
                bit_flip = 0;
            end
            if DATA(RAND_degradedIMAGE_tobeused_BSNN(j),RAND_degradedPIX_tobeused_BSNN(j,k),RAND_degradedBIT) == 0
                bit_flip = 1;
            end
            test__data_DEGRADED_SC(RAND_degradedIMAGE_tobeused_BSNN(j),RAND_degradedPIX_tobeused_BSNN(j,k),RAND_degradedBIT) = bit_flip; %FLIPPED
        end
    end
    
    % No need to get back to the decimal case, still on SC stream
    % test__data_DEGRADED_DEC_or_SC 10000x784xpackage size and noisy
    test__data_DEGRADED_DEC_or_SC = test__data_DEGRADED_SC;
    
    %FINAL_SAVE
    save('test__data_DEGRADED_SC.mat', 'test__data_DEGRADED_DEC_or_SC');
    
end %end of BSNN-case
%--------------------------------------------------------------------------

end %end of function