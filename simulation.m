clear   % 一旦ワークスペース内全変数を消去

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

body_line = line;   % ロボット本体のライン
wheel_line = gobjects(size(wheel,1));   % ホイール用のライン
for i = 1:size(wheel,1)
    wheel_line(i) = line;
end
cond_string = "待機中";    % 状態表示テキストの中身
message = text(0, -30, strcat("T = ",string(0.0),"[s],  ",cond_string),'Fontsize',20);  % 画面左上のテキスト
light_sensor_points = text(zeros(size(list_light_sensor,1),1), zeros(size(list_light_sensor,1),1), '〇', 'Color','red', 'Fontsize', 8);  % ライトセンサ表示点
range_sensor_points = text(zeros(size(list_range_sensor,1),1), zeros(size(list_range_sensor,1),1), '*', 'Color','magenta'); % 距離センサ表示点
range_sensor_line = gobjects(1,size(list_range_sensor,1));   % 距離センサ走査線
for i = 1:size(list_range_sensor,1)
    range_sensor_line(i) = line;
    range_sensor_line(i).Visible = range_line_visible;
    range_sensor_line(i).Color = 'g';
end

range_detect_points = zeros(2, size(list_range_sensor,1));  % 距離センサの到達点

state_robot = init_state + [10*(rand-0.5); 10*(rand-0.5); 10/360*2*pi*(rand-0.5)];  % ロボットの初期位置を決定
environmental_light_noise = 40 * (rand-0.5);    % 環境光ノイズの設定

delta_t = 0.01; % シミュレーション刻み時間
wait_N = -50;  % 開始までの時間
N = 18000;       % シミュレーション最大時間 3min
t = 0:delta_t:delta_t*(N-1);
t = t.';
q = zeros(N, 3);    % 状態履歴
u = zeros(N, 2);    % 入力履歴
z = zeros(N, size(list_light_sensor,1)+size(list_range_sensor,1));  % 測定履歴
control_input = [0.0;0.0];    % 制御入力：dutyR, dutyL (-1.0 ~ +1.0, duty rate
value_light_sensor = zeros(size(list_light_sensor,1),1);    % ライトセンサ取得値
value_range_sensor = zeros(size(list_range_sensor,1),1);    % 距離センサ取得値
simulation_cond = 1;    % 実行
movie_k = 0;    % 動画フレーム番号

for k = wait_N:1:N  % メインループ
    if k>0
        cond_string = "スタート";
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
    if simulation_cond<0    % 何らかの終了原因が生じた
        cond_string = "終了";
    end
    func.drawRobot(state_robot, body, body_line, wheel, wheel_line, list_light_sensor, light_sensor_points, list_range_sensor(:,1:2), range_sensor_points, range_detect_points, range_sensor_line);
    message.String = strcat("T = ",num2str(k*delta_t,'%3.2f'),"[s],  ", cond_string);
    
    if exist('save_video_name', 'var') == 1  % movie作成
        if mod(k,4) == 1
            movie_k = movie_k + 1;
            Movie(movie_k) = getframe(gcf);
        end
    else
        pause(delta_t/2);
    end
    drawnow limitrate
    
    if simulation_cond<0    % 何らかの終了原因が生じた
        break;
    end
    
end

clear controller % for clear perisistent variable
clear checkRobotPosition
clear robotSystem

if simulation_cond == 1
    disp("シミュレーション時間が終了しました");
end

% figure
% j = 1:k;
% plot(j, q(1:k,1), j, q(1:k,2));


if exist('save_video_name', 'var') == 1
    func.makeVideo(save_video_name, Movie);
end

