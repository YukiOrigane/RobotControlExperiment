x = 1600;
y = 1600;
field_size = [x, y];  % field size [x, y];

finish_zone = [1200; 1400; 180; 0]; % 終了ゾーン [pox; posy; 半径];

% MATLAB上で作成
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % 白っぽい色に初期化
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0（壁なし）に初期化

field_line(385:415, 1:400) = 0;
field_line(1:1600, 1185:1215) = 0;
for i = 1:785
    field_line(1:1200, i+400) = 250 - 20*round(i*250/785/20);
end
for j = 1:385
    field_line(1:1200, j+1215) = 250 - 20*round((385-j)*250/385/20);
end