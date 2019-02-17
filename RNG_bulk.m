function result = RNG_bulk(in, package_size, in_row, in_column)
%prob is a prospective stochastic input data

%in a for loop
for j=1:in_column
    for i=1:in_row
        s_1s = ((in(i,j)*2)+package_size)/2;
        s1 = false(1,(package_size));
        s1(1:s_1s) = true;
        package_ready = s1(randperm(numel(s1)));
        for k=1:package_size
            result(i,j,k) = package_ready(k);
        end
    end
end

% s1 = false(1,(package_size)) ;
% s1(1:prob) = true ;
% result = s1(randperm(numel(s1)));
end

