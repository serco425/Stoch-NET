function result = STN_bulk(stream, package_size, in_row, in_column)
%prob is a prospective stochastic input data

%in a for loop
for j=1:in_column
    for i=1:in_row
        for k=1:package_size
            s_1s = sum(stream(i,j,:));
            s_0s = package_size - s_1s;
            result(i,j) = (s_1s - s_0s)/2;           
        end
    end
end

end