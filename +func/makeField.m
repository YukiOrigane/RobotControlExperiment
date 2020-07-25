function makeField(field_folder)

field_size = zeros(1,2);  % field size [x, y];
% init_state = zeros(3,1); % ロボットの初期状態 [ posx; posy; theta ]; % robot.mへ移行
finish_zone = zeros(3,1); % 終了ゾーン [pox; posy; 半径];

run(strcat("fields/", field_folder, "/", "field_data.m"));

if isfile(strcat("fields/", field_folder, "/", "field_data.png")) == 1
    % 画像ファイルを読み込み作成
    image = imread(strcat("fields/", field_folder, "/", "field_data.png"));
    
    field_line = image(:,:,3);  % ラインは画像のB値を使う
    field_wall = image(:,:,1);  % 壁は画像のR値を使う
    
    field_line = 255 - field_line;
    for i=1:field_size(1,2)
        for j = 1:field_size(1,1)
            if field_wall(i,j) > 0
                field_wall(i,j) = 1;    % R値＞0で壁あり
            else
                field_wall(i,j) = 0;    % R値=0で壁なし
            end
        end
    end
end

% データをファイルに出力
save(strcat("fields/", field_folder, "/", "field"));

end
