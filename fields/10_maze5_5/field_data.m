x = 2530;
y = 2530;
field_size = [x, y];  % field size [x, y];

finish_zone = [1265; 765; 200; 0]; % �I���]�[�� [pox; posy; ���a];

% MATLAB��ō쐬
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % �����ۂ��F�ɏ�����
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0�i�ǂȂ��j�ɏ�����

% ����
field_wall(1:30,1:2530) = 1;
field_wall(500:530,1:1530) = 1;
field_wall(1000:1030,500:1530) = 1;
field_wall(1000:1030,2000:2530) = 1;
field_wall(1500:1530,1500:2030) = 1;
field_wall(2500:2530,1:2530) = 1;

% �c��
field_wall(1:2530,1:30) = 1;
field_wall(1000:2030,500:530) = 1;
field_wall(1000:2030,1000:1030) = 1;
field_wall(500:1030,1500:1530) = 1;
field_wall(1500:2530,1500:1530) = 1;
field_wall(500:1030,2000:2030) = 1;
field_wall(1500:2030,2000:2030) = 1;
field_wall(1:2530,2500:2530) = 1;