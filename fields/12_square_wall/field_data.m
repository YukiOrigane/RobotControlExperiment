x = 3000;
y = 1500;
field_size = [x, y];  % field size [x, y];

finish_zone = [505; 750; 200; 1]; % �I���]�[�� [pox; posy; ���a];

% MATLAB��ō쐬
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % �����ۂ��F�ɏ�����
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0�i�ǂȂ��j�ɏ�����

field_line(400:1250,2485:2515) = 20;
field_line(500:1250,485:515) = 20;


% ����
field_wall(1:30,1:3000) = 1;
field_wall(485:515,1:2000) = 1;
field_wall(985:1015,985:2015) = 1;
field_wall(1470:1500,1:3000) = 1;

% �c��
field_wall(1:1500,1:30) = 1;
field_wall(485:1015,985:1015) = 1;
field_wall(485:1015,1985:2015) = 1;
field_wall(1:1500,2970:3000) = 1;