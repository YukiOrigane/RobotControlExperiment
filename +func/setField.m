function [field_size, line, wall] = setField(folder)
    %{
    field_size = [3000, 1000];
    line = ones(field_size(1,2), field_size(1,1)).*252;   % 初期値白っぽい色
    line(485:515,:) = 20;   % 指定部分のみ黒線に変更
    
    wall = zeros(field_size(1,2), field_size(1,1));
    wall(10:990,1500:1520) = 1;     % 指定部分のみ壁がある
    %}
end

% imshowは縦方向に行，横方向に列をとる（行列の見た目まま）なので，xyとは反転するので注意