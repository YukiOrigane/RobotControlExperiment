function makeField(field_folder)

field_size = zeros(1,2);  % field size [x, y];
% init_state = zeros(3,1); % ���{�b�g�̏������ [ posx; posy; theta ]; % robot.m�ֈڍs
finish_zone = zeros(3,1); % �I���]�[�� [pox; posy; ���a];

run(strcat("fields/" , field_folder, "/", "field_data.m"));

if isfile(strcat("fields/" , field_folder, "/", "field_data.png")) == 1
    % �摜�t�@�C����ǂݍ��ݍ쐬
image = imread(strcat("fields/" , field_folder, "/", "field_data.png"));

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
end

% �f�[�^���t�@�C���ɏo��
save(strcat("fields/" , field_folder, "/", "field"));

end
