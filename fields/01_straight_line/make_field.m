clear   % ��U���[�N�X�y�[�X���S�ϐ�������

field_size = [3000, 1000];  % field size [x, y];

init_state = [700; 500; 0]; % ���{�b�g�̏������ [ posx; posy; theta ];

finish_zone = [2700; 500; 200]; % �I���]�[�� [pox; posy; ���a];

% �t�B�[���h���ϐ�������
field_line = ones(field_size(1,2), field_size(1,1)).*252;   % �����ۂ��F�ɏ�����
field_wall = zeros(field_size(1,2), field_size(1,1));       % 0�i�ǂȂ��j�ɏ�����

% MATLAB��ō쐬
field_line(485:515,:) = 20; % �w�蕔���̂ݍ����ɕύX
% field_wall(10:990,1500:1520) = 1;   % �w�蕔���݂̂P�i�ǂ���j�ɕύX

% �摜�t�@�C����ǂݍ��ݍ쐬
%{
image = imread("field_data.png");

field_line = image(:,:,3);  % ���C���͉摜��B�l���g��
field_wall = image(:,:,1);  % �ǂ͉摜��R�l���g��
field_line = 255 - field_line;
for i=1:field_size(1,2)
    for j = 1:field_size(1,1)
        if field_wall(i,j)>0
            field_wall(i,j) = 1;    % R�l��0�ŕǂ���
        else
            field_wall(i,j) = 0;    % R�l=0�ŕǂȂ�
        end
    end
end
%}

save("field");
