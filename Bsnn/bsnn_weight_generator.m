function result = bsnn_weight_generator(in, package_size, in_row, in_column)

%BIPOLAR ENCODING SCHEME
for i=1:in_row
    for j=1:in_column
        
        % weight = 1
        if in(i,j) == 1
            for k=1:package_size
                result(i,j,k) = true;
            end
        end
        
        % weight = -1
        if in(i,j) == -1
            for k=1:package_size
                result(i,j,k) = false;
            end
        end
        
    end
end

%UNIPOLAR ENCODING SCHEME
% s1 = false(1,(package_size)) ;
% s1(1:prob) = true ;
% result = s1(randperm(numel(s1)));
end

