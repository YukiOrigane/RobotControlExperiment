
field_size = [3000, 1000];  % field size [x, y];

finish_zone = [2700; 500; 200; 0]; % �I���]�[�� [pox; posy; ���a; �N��0 �Î~1];

% MATLAB��ō쐬
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % �����ۂ��F�ɏ�����
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0�i�ǂȂ��j�ɏ�����

% field_line(485:515,:) = 20; % �w�蕔���̂ݍ����ɕύX
field_wall(1:30,1:3000) = 1;   % �w�蕔���݂̂P�i�ǂ���j�ɕύX
field_wall(970:1000,1:3000) = 1;
field_wall(1:1000,1:30) = 1;
field_wall(1:1000,2970:3000) = 1;