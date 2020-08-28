%%%%%%%%%%%% PID_control.m %%%%%%%%%%%%%%
% P制御
% gainを要素に持つ 1*4 ベクトル (double)
% gain[1] : 直進成分ゲイン
% gain[2] : 回転成分ゲイン Kp
% gain[3] : 回転成分ゲイン Ki
% gain[4] : 回転成分ゲイン Kd
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function u = PID_control(t, delta_t, value_light_sensor, value_range_sensor, gain)
persistent sum_e pre_e

z = sum(value_light_sensor,'all')/5;
e = (160-z) / 160;

if isempty(sum_e)
    sum_e = 0;
    pre_e = e;
end
sum_e = sum_e + e*delta_t;
u = [1 1 1 1;1 -1 -1 -1]*diag(gain)*[1; e; sum_e; (e-pre_e)/delta_t];   % 変換行列 * ゲイン対角行列 * 量
pre_e = e;

%disp(z)
end
