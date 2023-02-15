function Worker_Accuracy_in_Parallel = BSNN_Test_Worker(package_size, no_of_hidden_layers, ACCURACY, TEST_RESULTS, labels_test, test__data_BSNN, w1_BSNN, w2_BSNN, w3_BSNN, b_w, pile_in_each_worker, K)

%sizing issues
[~, X_column, ~] = size(test__data_BSNN);
[~, w1_column, ~] = size(w1_BSNN);
[~, w2_column, ~] = size(w2_BSNN);
[~, w3_column, ~] = size(w3_BSNN);

for j = (((K-1)*(pile_in_each_worker))+1):K*(pile_in_each_worker) %possible input trials
    %FORWARD-PROPOGATING TEST SIGNALS
    for i = 1:(no_of_hidden_layers+1) % +2 is for input and the output layer
        %first weights for the input-first (hidden) layer relation / first layer output prep
        if i==1
            threshold1 = ((784*package_size)/2);
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
    end

end
Worker_Accuracy_in_Parallel = ACCURACY;
end