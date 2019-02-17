function MULed_and_SUMmed = MUL_and_SUM(sum,in1, in2, package_size);
%sum + (in1 * in2) as a conventional
%sum MUX (in1 EXNOR in2) as a stochastic

%unipolar encoding for MUX selection bit
input_stream_selection = RNG(package_size/2, package_size);

%first multiplying with EXNOR and then summing with the temporary 'sum'
MULed = (~(xor(in1,in2)));
    
MULed_and_SUMmed = mux2_to_1_adder(input_stream_selection, sum, reshape(MULed,1,package_size));

end
