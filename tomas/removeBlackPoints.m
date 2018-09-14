function [ wo_loc, wo_col, wo_norm ] = removeBlackPoints( model_loc, model_col, model_norm )

wo_loc = model_loc;
wo_col = model_col;
wo_norm = model_norm;

blackPoints = find((model_col(:,1) == 0) & (model_col(:,2) == 0) & (model_col(:,3) == 0));

wo_loc(blackPoints,:) = [];
wo_col(blackPoints,:) = [];
wo_norm(blackPoints,:) = [];

end

