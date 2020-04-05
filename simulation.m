clear   % ��U���[�N�X�y�[�X���S�ϐ�������

field_number = '01';

% save_video_name = 'movie';

time_constant = 0.1;

run("fields/set_field_list.m");
field_folder = field_list(field_number);

func.makeField(field_folder);

load( strcat("fields/" , field_folder, "/", "field") );

func.drawInit(field_size);

func.drawField(field_size, field_line, field_wall, finish_zone);
field_line = field_line.';
field_wall = field_wall.';

run("robot.m");

body_line = line;   % ���{�b�g�{�̂̃��C��
wheel_line = gobjects(size(wheel,1));   % �z�C�[���p�̃��C��
for i = 1:size(wheel,1)
    wheel_line(i) = line;
end
cond_string = "�ҋ@��";    % ��ԕ\���e�L�X�g�̒��g
message = text(0, -30, strcat("T = ",string(0.0),"[s],  ",cond_string),'Fontsize',20);  % ��ʍ���̃e�L�X�g
light_sensor_points = text(zeros(size(list_light_sensor,1),1), zeros(size(list_light_sensor,1),1), '�Z', 'Color','red', 'Fontsize', 8);  % ���C�g�Z���T�\���_
range_sensor_points = text(zeros(size(list_range_sensor,1),1), zeros(size(list_range_sensor,1),1), '*', 'Color','magenta'); % �����Z���T�\���_
range_sensor_line = gobjects(1,size(list_range_sensor,1));   % �����Z���T������
for i = 1:size(list_range_sensor,1)
    range_sensor_line(i) = line;
    range_sensor_line(i).Visible = range_line_visible;
    range_sensor_line(i).Color = 'g';
end

range_detect_points = zeros(2, size(list_range_sensor,1));  % �����Z���T�̓��B�_

state_robot = init_state + [10*(rand-0.5); 10*(rand-0.5); 10/360*2*pi*(rand-0.5)];  % ���{�b�g�̏����ʒu������
environmental_light_noise = 40 * (rand-0.5);    % �����m�C�Y�̐ݒ�

delta_t = 0.01; % �V�~�����[�V�������ݎ���
wait_N = -50;  % �J�n�܂ł̎���
N = 18000;       % �V�~�����[�V�����ő厞�� 3min
t = 0:delta_t:delta_t*(N-1);
t = t.';
q = zeros(N, 3);    % ��ԗ���
u = zeros(N, 2);    % ���͗���
z = zeros(N, size(list_light_sensor,1)+size(list_range_sensor,1));  % ���藚��
control_input = [0.0;0.0];    % ������́FdutyR, dutyL (-1.0 ~ +1.0, duty rate
value_light_sensor = zeros(size(list_light_sensor,1),1);    % ���C�g�Z���T�擾�l
value_range_sensor = zeros(size(list_range_sensor,1),1);    % �����Z���T�擾�l
simulation_cond = 1;    % ���s
movie_k = 0;    % ����t���[���ԍ�

for k = wait_N:1:N  % ���C�����[�v
    if k>0
        cond_string = "�X�^�[�g";
        if mod(k,5) == 0    % 20Hz
            value_light_sensor = func.getLightSensor(state_robot, list_light_sensor, field_line, environmental_light_noise);
            [value_range_sensor, range_detect_points] = func.getRangeSensor(state_robot, list_range_sensor, field_wall);
            control_input = controller(t(k,1), delta_t, value_light_sensor, value_range_sensor);
        end
        q(k,:) = state_robot;
        u(k,:) = control_input;
        z(k,:) = [value_light_sensor.', value_range_sensor.'];
    end
    if exist('time_constant','var') == 1
        state_robot = func.robotSystem(state_robot, control_input, wheel, delta_t, time_constant);
    else
        state_robot = func.robotSystem(state_robot, control_input, wheel, delta_t);
    end
    
    simulation_cond = simulation_cond * func.checkRobotPosition(state_robot, body, field_size, field_wall, finish_zone);
    if simulation_cond<0    % ���炩�̏I��������������
        cond_string = "�I��";
    end
    func.drawRobot(state_robot, body, body_line, wheel, wheel_line, list_light_sensor, light_sensor_points, list_range_sensor(:,1:2), range_sensor_points, range_detect_points, range_sensor_line);
    message.String = strcat("T = ",num2str(k*delta_t,'%3.2f'),"[s],  ", cond_string);
    
    if exist('save_video_name', 'var') == 1  % movie�쐬
        if mod(k,4) == 1
            movie_k = movie_k + 1;
            Movie(movie_k) = getframe(gcf);
        end
    else
        pause(delta_t/2);
    end
    drawnow limitrate
    
    if simulation_cond<0    % ���炩�̏I��������������
        break;
    end
    
end

clear controller % for clear perisistent variable
clear checkRobotPosition
clear robotSystem

if simulation_cond == 1
    disp("�V�~�����[�V�������Ԃ��I�����܂���");
end

% figure
% j = 1:k;
% plot(j, q(1:k,1), j, q(1:k,2));


if exist('save_video_name', 'var') == 1
    func.makeVideo(save_video_name, Movie);
end

