function line = setField(field_size)
    line = ones(field_size(1,2), field_size(1,1)).*252;   % 初期値白っぽい色
    line(485:515,:) = 20;
end

% imshowは縦方向に行，横方向に列をとる（行列の見た目まま）なので，xyとは反転するので注意