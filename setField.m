function [field_size, line, wall] = setField(folder)
    %{
    field_size = [3000, 1000];
    line = ones(field_size(1,2), field_size(1,1)).*252;   % �����l�����ۂ��F
    line(485:515,:) = 20;   % �w�蕔���̂ݍ����ɕύX
    
    wall = zeros(field_size(1,2), field_size(1,1));
    wall(10:990,1500:1520) = 1;     % �w�蕔���̂ݕǂ�����
    %}
end

% imshow�͏c�����ɍs�C�������ɗ���Ƃ�i�s��̌����ڂ܂܁j�Ȃ̂ŁCxy�Ƃ͔��]����̂Œ���