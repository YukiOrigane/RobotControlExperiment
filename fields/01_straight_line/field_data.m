
field_size = [3000, 1000];  % field size [x, y];

finish_zone = [2700; 500; 200]; % �I���]�[�� [pox; posy; ���a];

% MATLAB��ō쐬
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % �����ۂ��F�ɏ�����
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0�i�ǂȂ��j�ɏ�����

field_line(485:515,:) = 20; % �w�蕔���̂ݍ����ɕύX
% field_wall(10:990,1500:1520) = 1;   % �w�蕔���݂̂P�i�ǂ���j�ɕύX