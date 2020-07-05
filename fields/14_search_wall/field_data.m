x = 3000;
y = 1500;
field_size = [x, y];  % field size [x, y];

yg = round(1300*rand);  % ゴールy座標をランダム決定

finish_zone = [2700; yg; 200; 1]; % 終了ゾーン [pox; posy; 半径];

% MATLAB上で作成
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % 白っぽい色に初期化
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0（壁なし）に初期化

field_line(yg-15:yg+15, 2300:3000) = 20;

% 横線
field_wall(1:30,1:2200) = 1;
field_wall(1470:1500,1:2200) = 1;

% 縦線
field_wall(1:1500,1:30) = 1;
field_wall(yg-150:yg+150,2970:3000) = 1;