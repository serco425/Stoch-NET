function result = stream_generator(in, package_size, in_row, in_column)

%BIPOLAR ENCODING SCHEME
for i=1:in_row
    for j=1:in_column
        numerator = double(in(i,j));
        s_1s = (((numerator)+1)/2)*package_size;
        s1 = false(1,(package_size));
        s1(1:s_1s) = true;
        package_ready = s1;
        package_ready = s1(randperm(numel(s1)));
        for k=1:package_size
            result(i,j,k) = package_ready(k);
        end
    end
end

%UNIPOLAR ENCODING SCHEME
% s1 = false(1,(package_size)) ;
% s1(1:prob) = true ;
% result = s1(randperm(numel(s1)));
end

