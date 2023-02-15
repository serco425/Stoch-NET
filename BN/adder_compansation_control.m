    
for i = 1:7
    for j = 1:5
        for k  = 1:8
            deneme(i,j,k) = false;
        end
    end
end

            


%Adder compensation
    counter = 0;
    for j=1:5
        counter = 0;
        for i=1:7
            if deneme(i,j,1) == false && counter ~= 32
                deneme(i,j,:) = true;
                counter = counter + 16;
            end
        end
    end