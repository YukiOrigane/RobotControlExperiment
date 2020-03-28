clear   % 一旦ワークスペース内全変数を消去

field_size = [3000, 1000];  % field size [x, y];

init_state = [700; 500; 0]; % ロボットの初期状態 [ posx; posy; theta ];

finish_zone = [2700; 500; 200]; % 終了ゾーン [pox; posy; 半径];

% フィールド情報変数初期化
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % 白っぽい色に初期化
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0（壁なし）に初期化

% MATLAB上で作成
field_line(485:515,:) = 20; % 指定部分のみ黒線に変更
% field_wall(10:990,1500:1520) = 1;   % 指定部分のみ１（壁あり）に変更

% 画像ファイルを読み込み作成
%{
image = imread("field_data.png");

field_line = image(:,:,3);  % ラインは画像のB値を使う
field_wall = image(:,:,1);  % 壁は画像のR値を使う
field_line = 255 - field_line;
for i=1:field_size(1,2)
    for j = 1:field_size(1,1)
        if field_wall(i,j)>0
            field_wall(i,j) = 1;    % R値＞0で壁あり
        else
            field_wall(i,j) = 0;    % R値=0で壁なし
        end
    end
end
%}

save("field");
