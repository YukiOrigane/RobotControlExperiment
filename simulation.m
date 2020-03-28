run("robot.m");

field_folder = "02_line_and_circle";

load( strcat("fields/" , field_folder, "/", "field") );
% [field_size, field_line, field_wall] = setField(folder);
drawInit(field_size);

drawField(field_size, field_line, field_wall);
field_line = field_line.';
field_wall = field_wall.';

body_line = line;
time_display = text(0, 30, strcat("T = ",string(0.0),"[s]"),'Fontsize',20);
light_sensor_points = text(zeros(size(list_light_sensor,1),1), zeros(size(list_light_sensor,1),1), 'ÅZ', 'Color','red', 'Fontsize', 8);
range_sensor_points = text(zeros(size(list_range_sensor,1),1), zeros(size(list_range_sensor,1),1), '*', 'Color','magenta');
range_sensor_line = line;
range_detect_points = zeros(2, size(range_sensor_points,2));

% state_robot = [200;500;0];  % gposX, gposY, gtheta
state_robot = init_state;
control_input = [0.0;0.0];    % dutyR, dutyL (-1.0 ~ +1.0, duty rate

delta_t = 0.01;
N = 500;
t = 0:delta_t:delta_t*(N-1);
t = t.';
q = zeros(N, 3);
u = zeros(N, 2);

for k = 1:N
    q(k,:) = state_robot;
    u(k,:) = control_input;
    if mod(k,5) == 0    % 20Hz
        value_light_sensor = getLightSensor(state_robot, list_light_sensor, field_line);
        [value_range_sensor, range_detect_points] = getRangeSensor(state_robot, list_range_sensor, field_wall);
        control_input = controller(t(k,1), delta_t, value_light_sensor);
    end
    state_robot = robotSystem(state_robot, control_input, wheel, delta_t);
    drawRobot(state_robot, body, body_line, list_light_sensor, light_sensor_points, list_range_sensor(:,1:2), range_detect_points, range_sensor_line);
    time_display.String = strcat("T = ",num2str(k*delta_t,'%3.2f'),"[s]");
    pause(delta_t);
    drawnow limitrate
end

figure
plot(q(:,1), q(:,3))
% plot(t, u(:,1), t, u(:,2));