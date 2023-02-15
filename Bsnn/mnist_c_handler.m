isMNIST = 0; %0 -> MNIST digit | 1 -> MNIST fashion | 2 -> MNIST morph. thin
%Just for labels_test
[images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST);

    %Below is referenced from: http://kkms.org/index.php/kjm/article/viewFile/659/411
    %To view the images (first 100) comment out the following --->
%     figure
%     for i = 1:100
%     subplot(10,10,i)
%     digit = reshape((images_test(:, i)), [28,28]);
%     imshow(digit)
%     title(num2str(labels_test(i)))
%     end

%31st image as in mnist-c
% deneme = (reshape(images_test(:,31),[28,28]));
% imshow(deneme)

%Kullanırken double, ama çizdirirken uint8

%*******brightness*********************************************************
test_images_brightness = importdata('test_images_brightness.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_brightness(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_brightness(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_brightness.mat', 'digit_save');
%-------save--------
%*******brightness*********************************************************

%*******canny_edges********************************************************
test_images_canny_edges = importdata('test_images_canny_edges.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_canny_edges(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_canny_edges(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_canny_edges.mat', 'digit_save');
%-------save--------
%*******canny_edges*********************************************************

%*******dotted_line********************************************************
test_images_dotted_line = importdata('test_images_dotted_line.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_dotted_line(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_dotted_line(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_dotted_line.mat', 'digit_save');
%-------save--------
%*******dotted_line********************************************************

%*******fog****************************************************************
test_images_fog = importdata('test_images_fog.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_fog(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_fog(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_fog.mat', 'digit_save');
%-------save--------
%*******fog****************************************************************

%*******glass_blur*********************************************************
test_images_glass_blur = importdata('test_images_glass_blur.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_glass_blur(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_glass_blur(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_glass_blur.mat', 'digit_save');
%-------save--------
%*******glass_blur*********************************************************

%*******identity***********************************************************
test_images_identity = importdata('test_images_identity.txt');
%-------plot--------
figure
for i = 1:100
    subplot(10,10,i)
    digit_plot = transpose(reshape(uint8(test_images_identity(i, :)), [28,28]));
    imshow(digit_plot)
    title(num2str(labels_test(i)))
end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_identity(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_identity.mat', 'digit_save');
%-------save--------
%*******identity***********************************************************

%*******impulse_noise***********************************************************
test_images_impulse_noise = importdata('test_images_impulse_noise.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_impulse_noise(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_impulse_noise(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_impulse_noise.mat', 'digit_save');
%-------save--------
%*******impulse_noise***********************************************************

%*******motion_blur********************************************************
test_images_motion_blur = importdata('test_images_motion_blur.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_motion_blur(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_motion_blur(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_motion_blur.mat', 'digit_save');
%-------save--------
%*******motion_blur********************************************************

%*******images_rotate******************************************************
test_images_rotate = importdata('test_images_rotate.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_rotate(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_rotate(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_rotate.mat', 'digit_save');
%-------save--------
%*******images_rotate******************************************************

%*******scale**************************************************************
test_images_scale = importdata('test_images_scale.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_scale(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_scale(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_scale.mat', 'digit_save');
%-------save--------
%*******scale**************************************************************

%*******shear**************************************************************
test_images_shear = importdata('test_images_shear.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_shear(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_shear(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_shear.mat', 'digit_save');
%-------save--------
%*******shear**************************************************************

%*******shot_noise*********************************************************
test_images_shot_noise = importdata('test_images_shot_noise.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_shot_noise(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_shot_noise(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_shot_noise.mat', 'digit_save');
%-------save--------
%*******shot_noise*********************************************************

%*******spatter************************************************************
test_images_spatter = importdata('test_images_spatter.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_spatter(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_spatter(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_spatter.mat', 'digit_save');
%-------save--------
%*******spatter************************************************************

%*******stripe*************************************************************
test_images_stripe = importdata('test_images_stripe.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_stripe(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_stripe(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_stripe.mat', 'digit_save');
%-------save--------
%*******stripe*************************************************************

%*******translate**********************************************************
test_images_translate = importdata('test_images_translate.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_translate(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_translate(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_translate.mat', 'digit_save');
%-------save--------
%*******translate**********************************************************

%*******zigzag*************************************************************
test_images_zigzag = importdata('test_images_zigzag.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_zigzag(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_zigzag(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_zigzag.mat', 'digit_save');
%-------save--------
%*******zigzag*************************************************************

%**************************************************************************
%**************************************************************************
%*****************************LEFT-OVER************************************
%**************************************************************************
%**************************************************************************

%*******contrast*********************************************************
test_images_contrast = importdata('test_images_contrast.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_contrast(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_contrast(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_contrast.mat', 'digit_save');
%-------save--------
%*******contrast*********************************************************


%*******defocus_blur*********************************************************
test_images_defocus_blur = importdata('test_images_defocus_blur.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_defocus_blur(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_defocus_blur(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_defocus_blur.mat', 'digit_save');
%-------save--------
%*******defocus_blur*********************************************************


%*******elastic_transform*********************************************************
test_images_elastic_transform = importdata('test_images_elastic_transform.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_elastic_transform(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_elastic_transform(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_elastic_transform.mat', 'digit_save');
%-------save--------
%*******elastic_transform*********************************************************

%*******frost*********************************************************
test_images_frost = importdata('test_images_frost.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_frost(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_frost(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_frost.mat', 'digit_save');
%-------save--------
%*******frost*********************************************************

%*******gaussian_blur*********************************************************
test_images_gaussian_blur = importdata('test_images_gaussian_blur.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_gaussian_blur(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_gaussian_blur(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_gaussian_blur.mat', 'digit_save');
%-------save--------
%*******gaussian_blur*********************************************************


%*******gaussian_noise*********************************************************
test_images_gaussian_noise = importdata('test_images_gaussian_noise.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_gaussian_noise(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_gaussian_noise(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_gaussian_noise.mat', 'digit_save');
%-------save--------
%*******gaussian_noise*********************************************************

%*******inverse*********************************************************
test_images_inverse = importdata('test_images_inverse.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_inverse(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_inverse(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_inverse.mat', 'digit_save');
%-------save--------
%*******inverse*********************************************************




%*******jpeg_compression*********************************************************
test_images_jpeg_compression = importdata('test_images_jpeg_compression.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_jpeg_compression(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_jpeg_compression(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_jpeg_compression.mat', 'digit_save');
%-------save--------
%*******jpeg_compression*********************************************************



%*******line*********************************************************
test_images_line = importdata('test_images_line.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_line(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_line(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_line.mat', 'digit_save');
%-------save--------
%*******line*********************************************************




%*******pessimal_noise*****************************************************
test_images_pessimal_noise = importdata('test_images_pessimal_noise.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_pessimal_noise(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_pessimal_noise(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_pessimal_noise.mat', 'digit_save');
%-------save--------
%*******pessimal_noise*****************************************************




%*******pixelate***********************************************************
test_images_pixelate = importdata('test_images_pixelate.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_pixelate(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_pixelate(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_pixelate.mat', 'digit_save');
%-------save--------
%*******pixelate***********************************************************




%*******quantize***********************************************************
test_images_quantize = importdata('test_images_quantize.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_quantize(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_quantize(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_quantize.mat', 'digit_save');
%-------save--------
%*******quantize***********************************************************


%*******saturate***********************************************************
test_images_saturate = importdata('test_images_saturate.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_saturate(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_saturate(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_saturate.mat', 'digit_save');
%-------save--------
%*******saturate***********************************************************



%*******snow***************************************************************
test_images_snow = importdata('test_images_snow.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_snow(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_snow(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_snow.mat', 'digit_save');
%-------save--------
%*******snow***************************************************************


%*******speckle_noise******************************************************
test_images_speckle_noise = importdata('test_images_speckle_noise.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_speckle_noise(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_speckle_noise(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_speckle_noise.mat', 'digit_save');
%-------save--------
%*******speckle_noise******************************************************

%*******zoom_blur**********************************************************
test_images_zoom_blur = importdata('test_images_zoom_blur.txt');
%-------plot--------
% figure
% for i = 1:100
%     subplot(10,10,i)
%     digit_plot = transpose(reshape(uint8(test_images_zoom_blur(i, :)), [28,28]));
%     imshow(digit_plot)
%     title(num2str(labels_test(i)))
% end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_zoom_blur(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
%imshow(reshape(uint8(digit_save(31,:)),[28,28]))
save('test_images_zoom_blur.mat', 'digit_save');
%-------save--------
%*******zoom_blur**********************************************************



















%*******identity_again*****************************************************
test_images_identity_again = importdata('test_images_identity_again.txt');
%-------plot--------
figure
for i = 1:100
    subplot(10,10,i)
    digit_plot = transpose(reshape(uint8(test_images_identity_again(i, :)*255), [28,28]));
    imshow(digit_plot)
    title(num2str(labels_test(i)))
end
%-------plot--------
%-------save--------
for i = 1:10000
    digit_tranposed = transpose(reshape(test_images_identity_again(i, :), [28,28]));
    digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
end
%try for 1 image
imshow(reshape(uint8(digit_save(31,:)*255),[28,28]))
save('test_images_identity_again.mat', 'digit_save');
%-------save--------
%*******identity_again*****************************************************
