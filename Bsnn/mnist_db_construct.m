
function [images_train, images_test, labels_test, labels_train, images_train_SC, images_test_SC]= mnist_db_construct(isMNIST)

if isMNIST == 0
    %DETERMINISTIC DATA
    %load functions are referenced from: http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
    images_train = loadMNISTImages('train-images.idx3-ubyte');
    labels_train = loadMNISTLabels('train-labels.idx1-ubyte');
    images_test = loadMNISTImages('t10k-images.idx3-ubyte');
    labels_test = loadMNISTLabels('t10k-labels.idx1-ubyte');
    
    %STOCHASTIC DATA
    %[images_train_SC, images_test_SC]= DO_mnist_stochastic_stream(images_train, images_test, package_size, number_of_possible_in_TEST);
    images_test_SC = 1;
    images_train_SC = 1;
    
    %Below is referenced from: http://kkms.org/index.php/kjm/article/viewFile/659/411
    %To view the images (first 100) comment out the following --->
    % figure
    % for i = 1:100
    % subplot(10,10,i)
    % digit = reshape((images_train(:, i)), [28,28]);
    % imshow(digit)
    % title(num2str(labels_train(i)))
    % end
end

if isMNIST == 1
    %DETERMINISTIC DATA
    %load functions are referenced from: https://github.com/zalandoresearch/fashion-mnist
    images_train = loadMNISTImages('F_train-images.idx3-ubyte');
    labels_train = loadMNISTLabels('F_train-labels.idx1-ubyte');
    images_test = loadMNISTImages('F_t10k-images.idx3-ubyte');
    labels_test = loadMNISTLabels('F_t10k-labels.idx1-ubyte');
    
    %STOCHASTIC DATA
    %[images_train_SC, images_test_SC]= DO_mnist_stochastic_stream(images_train, images_test, package_size, number_of_possible_in_TEST);
    images_test_SC = 1;
    images_train_SC = 1;
end

if isMNIST == 2 %Morphed Thin MNIST Images
    %DETERMINISTIC DATA
    %load functions are referenced from: https://github.com/zalandoresearch/fashion-mnist
    images_train = loadMNISTImages('morph_thin_train-images.idx3-ubyte');
    labels_train = loadMNISTLabels('morph_thin_train-labels.idx1-ubyte');
    images_test = loadMNISTImages('morph_thin_t10k-images.idx3-ubyte');
    labels_test = loadMNISTLabels('morph_thin_t10k-labels.idx1-ubyte');
    
    for i = 1:10000
        digit_tranposed = transpose(reshape(images_test(:, i), [28,28]));
        digit_save(i,:) = double(reshape(digit_tranposed, [1,784]));
    end
    
    images_test = digit_save;
    
    %STOCHASTIC DATA
    %[images_train_SC, images_test_SC]= DO_mnist_stochastic_stream(images_train, images_test, package_size, number_of_possible_in_TEST);
    images_test_SC = 1;
    images_train_SC = 1;
end


if isMNIST == 3 %Morphed Thin MNIST Images
    %DETERMINISTIC DATA
    %load functions are referenced from: https://github.com/zalandoresearch/fashion-mnist
    images_train = loadMNISTImages('morph_thick_train-images.idx3-ubyte');
    labels_train = loadMNISTLabels('morph_thick_train-labels.idx1-ubyte');
    images_test = loadMNISTImages('morph_thick_t10k-images.idx3-ubyte');
    labels_test = loadMNISTLabels('morph_thick_t10k-labels.idx1-ubyte');
    
    %STOCHASTIC DATA
    %[images_train_SC, images_test_SC]= DO_mnist_stochastic_stream(images_train, images_test, package_size, number_of_possible_in_TEST);
    images_test_SC = 1;
    images_train_SC = 1;
end


if isMNIST == 5 %Morphed Swel MNIST Images
    %DETERMINISTIC DATA
    %load functions are referenced from: https://github.com/zalandoresearch/fashion-mnist
    images_train = loadMNISTImages('morph_swel_train-images.idx3-ubyte');
    labels_train = loadMNISTLabels('morph_swel_train-labels.idx1-ubyte');
    images_test = loadMNISTImages('morph_swel_t10k-images.idx3-ubyte');
    labels_test = loadMNISTLabels('morph_swel_t10k-labels.idx1-ubyte');
    
    %STOCHASTIC DATA
    %[images_train_SC, images_test_SC]= DO_mnist_stochastic_stream(images_train, images_test, package_size, number_of_possible_in_TEST);
    images_test_SC = 1;
    images_train_SC = 1;
end


end

