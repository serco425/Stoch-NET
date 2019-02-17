
%%
close all
clear all
clc
output_neuron_size = 1;
package_size = 4;%the number of the bits in each of the input stream

learning_rate = 0.1; %eta

%this will be loaded later via synthetic function
input__data = ones(4,2); 

%get number of hidden layers from the user
prompt = 'How many hidden layer to be constructed? ';
no_of_hidden_layers = input(prompt);

%get size of hidden layers from the user
str = 'Enter the amount of neurons in layer ';
for i = 1:no_of_hidden_layers
    prompt = sprintf('%s%d  ',str,i);
    hidden_layer_sizes{i} = input(prompt);
end

%giving the names
for k = no_of_hidden_layers:-1:1
    hidden_layer_names{k} = sprintf('hidden_layer_%d',k);
end

%input row*column   #rows=samples & #columns=classes
[in_row, in_column] = size(input__data);

no_of_classes = in_column;

%giving the names
for k = (no_of_hidden_layers+1):-1:1
    weight_names{k} = sprintf('weights_%d',k);
end

%putting initially zeros into the weights
%weights can be variable for each layer
for i = 1:(no_of_hidden_layers+1)
    %first weights for the input-first (hidden) layer relation
    if i==1
        weight_names{i} = zeros(no_of_classes,hidden_layer_sizes{i});
    end
    
    %%output layer and the one previous
    if i==(no_of_hidden_layers+1)
        weight_names{i} = zeros(hidden_layer_sizes{i-1},output_neuron_size);
    end
    
    %weight in-between hidden layers
    if i~=1 && i~=(no_of_hidden_layers+1)
        weight_names{i} = zeros(hidden_layer_sizes{i-1},hidden_layer_sizes{i});
    end
end

%PREPARATION OF THE DATA & WEIGHTS INTO STOCHASTIC DOMAIN

%All inputs are transformed into the stochastic streams
input_stoc = RNG_bulk(input__data, package_size, in_row, in_column);

%output labels
expected_output = [1,1,-1,-1];

%hatýrlatma: dataya struct içerisinde bu þekilde ulaþýyorsun
%weight_names{1}(1,1)

%this is a function directs the weights into the bulk binary number
%generator is in bipolar form [-1, 1]
weights_in_stoc = get_stoch_weights(weight_names, no_of_hidden_layers, hidden_layer_sizes, no_of_classes, output_neuron_size, package_size);

learning_iteration = 6;
number_of_possible_in = 4;

%Do-it-all in the loop, in an amount of learning iteration
for p = 1:learning_iteration %epoch
   for j = 1:number_of_possible_in %possible input trials
       
       %FORWARD-PROPOGATING SIGNALS
       for i = 1:(no_of_hidden_layers+2)
            %first weights for the input-first (hidden) layer relation
            if i==1
                %data type conversion to make it easy
                in2_cell2mat = cell2mat(weights_in_stoc(1,i,1));
                
                %binary stochastic matrix multiplication 
                layer_wise_stoch_out{1} = stochastic_neuron(input_stoc(j,:,:), in2_cell2mat, i, no_of_hidden_layers, package_size);
                
                % BINARY -->  DECIMAL --> F_ACTIVATION(decimal) --> 0.XXX
    
                %layer_wise_stoch_out (in binary) will be STNed first and this decimal number will be inputted into activation function
                [layerwise_row_size layerwise_column_size layerwise_package_size] = size(layer_wise_stoch_out{1});
                
                %getting decimal version of stochastic number
                layer_wise_stoch_out_STN{1} = STN_bulk(layer_wise_stoch_out{1}, package_size, layerwise_row_size, layerwise_column_size);
                
                %activation function
                %***************************TANH***************************
                for m=1:layerwise_column_size
                    for z=1:layerwise_row_size             
                        layer_wise_stoch_out_ACT{1}(z, m) = tanh(layer_wise_stoch_out_STN{1}(z, m));
                    end
                end
                %***************************TANH***************************
                
                % 0.XXX (ceiling opertation can be used) --> BINARY       
                %All is transformed into the stochastic streams
                layer_wise_stoch_out{1} = RNG_bulk(ceil(layer_wise_stoch_out_ACT{1}), package_size, layerwise_row_size, layerwise_column_size);
                
            end

            %weight in-between hidden layers
            if i~=1 && i~=(no_of_hidden_layers+2)
                layer_wise_hidden_cell2mat = cell2mat(layer_wise_stoch_out(1,i-1,1));%this time not the input, but the first hidden layer
                layer_wise_stoch_out{i} = stochastic_neuron(layer_wise_hidden_cell2mat,weights_in_stoc{i}, i, no_of_hidden_layers, package_size);
            
                % BINARY -->  DECIMAL --> F_ACTIVATION(decimal) --> 0.XXX
    
                %layer_wise_stoch_out (in binary) will be STNed first and this decimal number will be inputted into activation function
                [layerwise_row_size layerwise_column_size layerwise_package_size] = size(layer_wise_stoch_out{i});
                
                %getting decimal version of stochastic number
                layer_wise_stoch_out_STN{i} = STN_bulk(layer_wise_stoch_out{i}, package_size, layerwise_row_size, layerwise_column_size);
                
                %activation function
                %***************************TANH***************************
                for mth=1:layerwise_column_size
                    for zth=1:layerwise_row_size             
                        layer_wise_stoch_out_ACT{i}(zth, mth) = tanh(layer_wise_stoch_out_STN{i}(zth, mth));
                    end
                end
                %***************************TANH***************************
                
                % 0.XXX (ceiling opertation can be used) --> BINARY       
                %All is transformed into the stochastic streams
                layer_wise_stoch_out{i} = RNG_bulk(ceil(layer_wise_stoch_out_ACT{i}), package_size, layerwise_row_size, layerwise_column_size);
            end
 
% 
%             %%output layer and the one previous
%             if i==(no_of_hidden_layers+2)
%                 layer_wise_stoch_out{i} = stochastic_neuron(layer_wise_stoch_out{i-1},weights_in_stoc{i}, i, no_of_hidden_layers, package_size);
%             end
       end
       
       %While still in the ith element on the input samples
       %The error (sigmas) will be calculated in the non-stochastic domain
              
       %DETERMINISTIC
       %BACKPROPOGATION
       %going from the last one to the second
       %bpg is the backpropogation indice
       for bpg = (no_of_hidden_layers+1):-1:2
            
           if bpg==(no_of_hidden_layers+1) %last layer (output layer)
                %getting the size of each layer  
                [layerwise_row_size_ACT layerwise_column_size_ACT] = size(layer_wise_stoch_out_ACT{bpg});
                [layerwise_row_size_ACT_back layerwise_column_size_ACT_back] = size(layer_wise_stoch_out_ACT{bpg-1});
                
                %calculation the sigma and the error
                for m=1:layerwise_column_size_ACT
                    for z=1:layerwise_row_size_ACT
                        %At the ith layer and jth neuron
                        E{bpg}(z, m) = (expected_output(j) - layer_wise_stoch_out_ACT{bpg}(z, m)); %first time error calculation
                        %this will be removed for the following code part,
                        %the reason why, in this layer previous_layer_based error will be calculated in advance
                        
                        %last layer related sigma
                        sigma{bpg}(z, m) = layer_wise_stoch_out_STN{bpg}(z, m) * E{bpg}(z, m) * (1-((tanh(layer_wise_stoch_out_STN{bpg}(z, m)))*(tanh(layer_wise_stoch_out_STN{bpg}(z, m)))));
                    end
                end              
                
                %Distributing the sigmas back onto the right; into the
                %previous layer by multiplying the weights
                for zsig=1:layerwise_column_size_ACT_back;
                    for msig=1:layerwise_column_size_ACT
                        sigma_{bpg-1}(zsig, msig) = weight_names{bpg}(zsig, msig)*sigma{bpg}(1, msig);
                    end
                end
                
                %Cumulative error sum of each previous forward path go into the backward
                sigma{bpg-1} = transpose(sum(sigma_{bpg-1},2)); %error actually
                
                %sigma_back_neuron is not ready yet
                %layer_wise_stoch_out_STN{bpg}(z, m) * E{bpg}(z, m) * (1-((tanh(layer_wise_stoch_out_STN{bpg}(z, m)))*(tanh(layer_wise_stoch_out_STN{bpg}(z, m)))));
                %i.e. sigma = derivative_of_act_fcn * STN_out * sigma{bpg-1}
                
                E{bpg-1} = (sigma{bpg-1});
                
                
           end
           
           %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
           %otherwise after the last layer
           if bpg~=(no_of_hidden_layers+1) %on the hidden layer
                %getting the size of each layer  
                [layerwise_row_size_ACT layerwise_column_size_ACT] = size(layer_wise_stoch_out_ACT{bpg});
                [layerwise_row_size_ACT_back layerwise_column_size_ACT_back] = size(layer_wise_stoch_out_ACT{bpg-1});
                
                %calculation the sigma and the error
                for m=1:layerwise_column_size_ACT
                    for z=1:layerwise_row_size_ACT
                        %At the ith layer and jth neuron
                        %E{bpg}(z, m) = (expected_output(j) - layer_wise_stoch_out_ACT{bpg}(z, m));
                        %the same sigma (as on the previous block) and is updated with sigma = derivative_of_act_fcn * STN_out * sigma{bpg-1}
                        sigma{bpg}(z, m) = layer_wise_stoch_out_STN{bpg}(z, m) * E{bpg}(z, m) * (1-((tanh(layer_wise_stoch_out_STN{bpg}(z, m)))*(tanh(layer_wise_stoch_out_STN{bpg}(z, m)))));
                    end
                end
                %Distributing the sigmas back onto the left; into the
                %previous layer by multiplying the weights
                for zsig=1:layerwise_column_size_ACT_back;
                    for msig=1:layerwise_column_size_ACT
                        sigma_{bpg-1}(zsig, msig) = weight_names{bpg}(zsig, msig)*sigma{bpg}(1, msig);
                    end
                end
                
                %Cumulative error sum of each previous forward path go into the backward
                sigma{bpg-1} = transpose(sum(sigma_{bpg-1},2)); %error actually, sigma will be updated
                %reason why sigma is not ready yet
                %layer_wise_stoch_out_STN{bpg}(z, m) * E{bpg}(z, m) * (1-((tanh(layer_wise_stoch_out_STN{bpg}(z, m)))*(tanh(layer_wise_stoch_out_STN{bpg}(z, m)))));
                %i.e. sigma = STN_out * E * derivative_of_act_fcn is needed
                %sigma{bpg-1} as sigma{bpg} in the next lines (when bpg = bpg-1)
                
                E{bpg-1} = (sigma{bpg-1});
                
                if bpg==2 %if we are about to finish
                    %getting the size of each layer  
                    [layerwise_row_size_ACT layerwise_column_size_ACT] = size(layer_wise_stoch_out_ACT{2});
                    [layerwise_row_size_ACT_back layerwise_column_size_ACT_back] = size(layer_wise_stoch_out_ACT{2-1});
                    
                    %calculation the sigma and the error
                    for m=1:layerwise_column_size_ACT
                        for z=1:layerwise_row_size_ACT
                            %At the ith layer and jth neuron
                            %E{bpg}(z, m) = (expected_output(j) - layer_wise_stoch_out_ACT{bpg}(z, m));
                            sigma{bpg}(z, m) = layer_wise_stoch_out_STN{bpg}(z, m) * E{bpg}(z, m) * (1-((tanh(layer_wise_stoch_out_STN{bpg}(z, m)))*(tanh(layer_wise_stoch_out_STN{bpg}(z, m)))));
                        end
                    end
                end % end of if bpg=2
           end % end of if not on the last layer; if bpg~=(no_of_hidden_layers+1)
       end % end of backpropogation
       
       %UPDATE
       % w = w +- eta * ACT * sigma
       %Errors are propogated; sigmas are ready, weights are to be updataed
       for upd = 1:no_of_hidden_layers+1
            [weight_row_size weight_column_size] = size(weight_names{upd});
            
            for r_weight=1:weight_row_size;
                for c_weight=1:weight_column_size
                    weight_names{upd}(r_weight, c_weight) = learning_rate * layer_wise_stoch_out_ACT{upd}(1, c_weight) * sigma{upd}(1, c_weight);
                end
            end
       end % end of UPDATE
       
       
   end % end of the j th input; each weights to be updated via backpropogation
end % EPOCH count


