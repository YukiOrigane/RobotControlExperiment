
field_size = [2000, 2000];  % field size [x, y];

finish_zone = [1000+800*sin(pi()/6); 1000-800*cos(pi()/6); 200; 0]; % 終了ゾーン [pox; posy; 半径; 侵入0 静止1];

% MATLAB上で作成
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % 白っぽい色に初期化
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0（壁なし）に初期化

c = field_size./2;
r1 = 780;
r2 = 820;
for i = 1:field_size(1)
    for j = 1:field_size(2)
        r = norm([i,j]-c);
        if r1<r && r<r2
            field_line(i,j) = 20; % 指定部分のみ黒線に変更
        end
    end
end

% field_wall(10:990,1500:1520) = 1;   % 指定部分のみ１（壁あり）に変更