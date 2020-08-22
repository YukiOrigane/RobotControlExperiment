x = 2400;
y = 1201;
field_size = [x, y];  % field size [x, y];

finish_zone = [2150; 620; 170; 0]; % 終了ゾーン [pox; posy; 半径];

% MATLAB上で作成
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % 白っぽい色に初期化
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0（壁なし）に初期化

% field_line(300:330,1:1500) = 20; % 指定部分のみ黒線に変更
% field_line(300:700,1485:1515) = 20;
% field_line(670:700,1485:2600) = 20;
% field_line(300:700,2585:2615) = 20;
% field_wall(10:990,1500:1520) = 1;   % 指定部分のみ１（壁あり）に変更