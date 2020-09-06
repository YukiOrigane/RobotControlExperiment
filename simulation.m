function simulation(field_id, controller_func, control_param)

clearvars -except field_id controller_func control_param   % 一旦ワークスペース内全変数を消去
close all;

if ~exist('field_id','var')    % 定義されてなければ代入
    field_id = '01';
end

if ~exist('controller_func','var')
    controller_func = @controllers.controller;
end

if ~exist('control_param','var')
    control_param = [0.5 1];
end

% save_video_name = 'movie';

run("fields/set_field_list.m");
field_folder = field_list(field_id);

func.makeField(field_folder);

load( strcat("fields/" , field_folder, "/", "field") );

figure;
ax = gca;
func.drawInit(ax, field_size);

func.drawField(ax, field_size, field_line, field_wall, finish_zone);
field_line = field_line.';
field_wall = field_wall.';

is_light_sensor_visible = true;  % ライトセンサ表示するか否か
% time_constant = 0.1;    % 時定数の初期設定値
viscocity = 0.1;    % 粘性の初期設定値

% run("robot.m"); ------------------------------------------
init_state = [200; 500; 0]; % ロボットの初期状態 [ posx; posy; theta ];

body = [100 80; -100 80; -100 -80; 100 -80];
wheel = [0 90; 0 -90];

list_light_sensor = ones(2,17)*100;
list_light_sensor(2,:) = 0:2.5:40;   % センサ17つ
list_light_sensor = list_light_sensor.';
list_range_sensor = [100 0 0;];

range_line_visible = 'off';
is_light_sensor_visible = true;

system_lebel = 1;   % システムのリアル度を変更
% ----------------------------------------------------------

run("list_system_config.m");    % システム設定の読み込み
system_config('initial_position_noise') = "off";

if isKey(field_init_state, field_id)  % 初期位置がフィールドで指定されているか
    init_state = field_init_state(field_id);
end

body_line = line;
wheel_line = [line, line];
cond_string = "待機中";
message = text(0, -30, strcat("T = ",string(0.0),"[s],  ",cond_string),'Fontsize',20);
light_sensor_points = text(zeros(size(list_light_sensor,1),1), zeros(size(list_light_sensor,1),1), '〇', 'Color','red', 'Fontsize', 8);
range_sensor_points = text(zeros(size(list_range_sensor,1),1), zeros(size(list_range_sensor,1),1), '*', 'Color','magenta');
for i = 1:size(list_range_sensor,1)
    range_sensor_line(i) = line;
    range_sensor_line(i).Visible = range_line_visible;
    range_sensor_line(i).Color = 'g';
end
% range_sensor_line.Visible = repmat(range_line_visible,1,2);

range_detect_points = zeros(2, size(list_range_sensor,1));

if system_config('initial_position_noise') == "on"
    state_robot = init_state + [10*(rand-0.5); 10*(rand-0.5); 10/360*2*pi*(rand-0.5)];
else
    state_robot = init_state;
end

environmental_light_noise = 40 * (rand-0.5);

delta_t = 0.01;
wait_N = -50;  % 開始までの時間
% N = 18000;       % シミュレーション最大時間 3min
N = 3000;
t = 0:delta_t:delta_t*(N-1);
t = t.';
q = zeros(N, 3);
u = zeros(N, 2);
z = zeros(N, size(list_light_sensor,1)+size(list_range_sensor,1));
control_input = [0.0;0.0];    % dutyR, dutyL (-1.0 ~ +1.0, duty rate
value_light_sensor = zeros(size(list_light_sensor,1),1);
value_range_sensor = zeros(size(list_range_sensor,1),1);
simulation_cond = 1;    % 実行
global stop_call
stop_call = false;
movie_k = 0;

for k = wait_N:N
    if k > 0
        cond_string = "スタート";
        if mod(k,5) == 0    % 20Hz
            value_light_sensor = func.getLightSensor(state_robot, list_light_sensor, field_line, environmental_light_noise);
            [value_range_sensor, range_detect_points] = func.getRangeSensor(state_robot, list_range_sensor, field_wall);
            % control_input = controller(t(k,1), delta_t, value_light_sensor, value_range_sensor);
            control_input = controller_func(t(k,1), delta_t, value_light_sensor, value_range_sensor, control_param);
        end
        q(k,:) = state_robot;
        u(k,:) = control_input;
        z(k,:) = [value_light_sensor.', value_range_sensor.'];
    end
    % if exist('time_constant','var') == 1
    %     state_robot = func.robotSystem(state_robot, control_input, wheel, delta_t, time_constant, viscocity);
    % else
    %     state_robot = func.robotSystem(state_robot, control_input, wheel, delta_t);
    % end
    state_robot = func.robotSystem(state_robot, control_input, wheel, delta_t, system_config);
    
    simulation_cond = simulation_cond * func.checkRobotPosition(state_robot, body, field_size, field_wall, finish_zone);
    if simulation_cond < 0    % 何らかの終了原因が生じた
        cond_string = "終了";
    end
    func.drawRobot(state_robot, body, body_line, wheel, wheel_line, list_light_sensor, light_sensor_points, list_range_sensor(:,1:2), range_sensor_points, range_detect_points, range_sensor_line, is_light_sensor_visible);
    message.String = strcat("T = ", num2str(k*delta_t, '%3.2f'), "[s], ", cond_string);
    
    if exist('save_video_name', 'var') == 1  % movie作成
        if mod(k,4) == 1
            movie_k = movie_k + 1;
            Movie(movie_k) = getframe(gcf);
        end
    else
        pause(delta_t/2);
    end
    drawnow limitrate
    pause(0.001);
    
    if simulation_cond < 0 || stop_call  % ループを抜け出す
        break;
    end
end

clear PID_control
clear checkRobotPosition
clear robotSystem

if simulation_cond == 1
    disp("シミュレーション時間が終了しました");
end

figure
j = 1:k;
line([1,k]*delta_t,[160,160], 'Color','g');
hold on
plot(j.*delta_t, sum(z(1:k,1:17)/17, 2));
legend("目標値","計測値")
xlabel("時刻[s]")
ylabel("センサ値")
grid on

if exist('save_video_name', 'var') == 1
    func.makeVideo(save_video_name, Movie);
end

end
