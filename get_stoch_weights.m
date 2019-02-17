function weights_stoc = get_stoch_weights(weight_names, no_of_hidden_layers, hidden_layer_sizes, no_of_classes, output_neuron_size, package_size)
    %weights can be variable for each layer
    for i = 1:(no_of_hidden_layers+1)
        %first weights for the input-first (hidden) layer relation
        if i==1
            weights_stoc{i} = RNG_bulk(weight_names{i}, package_size, no_of_classes, hidden_layer_sizes{i});
        end

        %%output layer and the one previous
        if i==(no_of_hidden_layers+1)
            weights_stoc{i} = RNG_bulk(weight_names{i}, package_size, hidden_layer_sizes{i-1}, output_neuron_size);
            %weight_names{i} = zeros(output_neuron_size,hidden_layer_sizes{no_of_hidden_layers});
        end

        %weight in-between hidden layers
        if i~=1 && i~=(no_of_hidden_layers+1)
            weights_stoc{i} = RNG_bulk(weight_names{i}, package_size, hidden_layer_sizes{i-1}, hidden_layer_sizes{i});
            %weight_names{i} = zeros(hidden_layer_sizes{i-1},hidden_layer_sizes{i});
        end
    end
end
