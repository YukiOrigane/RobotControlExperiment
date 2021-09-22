%%%%%%%%%%%% FF_Controller.m %%%%%%%%%%%%%%
% Control for FF
% gainを要素に持つ 1*2 ベクトル (double)
% gain[1] : 直進成分ゲイン
% gain[2] : 回転成分ゲイン
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u = FF_control(t, delta_t, value_light_sensor, value_range_sensor, gain)
    
    u = [1 1;1 -1]*diag(gain)*[1; 0];   % 変換行列 * ゲイン対角行列 * 量

end