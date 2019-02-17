function [result] = mux2_to_1_adder(s0, x1, x2)
 result = ((~s0)&x1 | (s0)&x2);
end