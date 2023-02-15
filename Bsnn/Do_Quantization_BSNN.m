%To quantize/binarize the values
function result = Do_Quantization_BSNN(Q, min, max, Q_or_B, toBeQuantized)

  %Quantization Case
  if Q_or_B == 1
    %result = (floor(toBeQuantized/Q)*Q)+(Q/2);
    result = (round(toBeQuantized/Q)*Q);

    result(result <= min) = min;
    result(result >= max) = max;
  end
  
  %Binarization Case
  if Q_or_B == 2
% will be updated
%     result = sign(toBeQuantized);
%     result(result == 0) = 1;
  end
  
  
  
  
% if isFloorOrRoundOrCeil == 1
%     %This is floor    
% end
% 
% if isFloorOrRoundOrCeil == 2
%     %This is round
%     Q = (max-min)/L;
%     result = round(toBeQuantized/Q)*Q;
% end
% 
% if isFloorOrRoundOrCeil == 3
%     %This is ceil    
% end


end