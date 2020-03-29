
field_size = [3000, 1000];  % field size [x, y];

finish_zone = [2700; 500; 200]; % 終了ゾーン [pox; posy; 半径];

% MATLAB上で作成
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % 白っぽい色に初期化
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0（壁なし）に初期化

field_line(485:515,:) = 20; % 指定部分のみ黒線に変更
% field_wall(10:990,1500:1520) = 1;   % 指定部分のみ１（壁あり）に変更