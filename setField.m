function line = setField(field_size)
    line = ones(field_size(1,2), field_size(1,1)).*252;   % �����l�����ۂ��F
    line(485:515,:) = 20;
end

% imshow�͏c�����ɍs�C�������ɗ���Ƃ�i�s��̌����ڂ܂܁j�Ȃ̂ŁCxy�Ƃ͔��]����̂Œ���