x = 3000;
y = 1000;
field_size = [x, y];  % field size [x, y];

finish_zone = [2600; 300; 200; 0]; % �I���]�[�� [pox; posy; ���a];

% MATLAB��ō쐬
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % �����ۂ��F�ɏ�����
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0�i�ǂȂ��j�ɏ�����

field_line(300:330,1:1500) = 20; % �w�蕔���̂ݍ����ɕύX
field_line(300:700,1485:1515) = 20;
field_line(670:700,1485:2600) = 20;
field_line(300:700,2585:2615) = 20;
% field_wall(10:990,1500:1520) = 1;   % �w�蕔���݂̂P�i�ǂ���j�ɕύX