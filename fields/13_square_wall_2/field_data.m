x = 3000;
y = 1500;
field_size = [x, y];  % field size [x, y];

finish_zone = [250; 750; 200; 1]; % �I���]�[�� [pox; posy; ���a];

% MATLAB��ō쐬
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % �����ۂ��F�ɏ�����
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0�i�ǂȂ��j�ɏ�����

field_line(250:1250,2785:2815) = 20;
field_line(500:1250,235:165) = 20;


% ����
field_wall(1:30,1:3000) = 1;
field_wall(435:455,1:2500) = 1;
field_wall(985:1015,485:1515) = 1;
field_wall(985:1015,1915:2515) = 1;
field_wall(1470:1500,1:1200) = 1;
field_wall(1470:1500,1600:3000) = 1;

% �c��
field_wall(1:1500,1:30) = 1;
field_wall(450:1015,485:515) = 1;
field_wall(435:1015,2485:2515) = 1;
field_wall(1:1500,2970:3000) = 1;