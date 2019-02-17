function layer_wise_stoch_out_result = stochastic_neuron(input_stoc_, weights_in_stoc_, i, no_of_hidden_layers, package_size)

%Sizes are defined
[x1_row, x1_column, sdsd] = size(input_stoc_);
[x2_row, x2_column, rtrt] = size(weights_in_stoc_);

%Some like standart matrix multiplication; instead bit streams are treated
for row = 1:x1_row
    for col = 1:x2_column
       %an empty, temporary 0 is created
       the_sum_temp = RNG(0, package_size);
       for k = 1 : x1_column
           %in1_cell2mat = cell2mat(input_stoc);
           %in2_cell2mat = cell2mat(weights_in_stoc_(k,col,:));
           the_sum_temp = MUL_and_SUM(the_sum_temp,input_stoc_(row,k,:), weights_in_stoc_(k,col,:), package_size);  
           %zzk = the_sum_temp,input_stoc(row,k,:) & weights_in_stoc_(k,col,:);
       end
       %send by a loop
       for index_ = 1:package_size
           theMatrixProduct(row, col, index_) = the_sum_temp(index_);
       end
    end
end

%layer_wise_stoch_out_result = reshape(theMatrixProduct,1,package_size);
layer_wise_stoch_out_result = theMatrixProduct;

end