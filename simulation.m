
drawInit();

state_robot = [200;500;0];  % gposX, gposY, gtheta
control_input = [0.0;-0.0];    % dutyR, dutyL (-1.0 ~ +1.0, duty rate)

delta_t = 0.001;
N = 30000;
t = 0:delta_t:delta_t*(N-1);

body_line = line;

for k = 1:N
    % value_light_sensor = getSensorValue(state, list_light_sensor);
    % control_input = robotControl(state_robot, value_light_sensor);
    % control_input = robotControl(t, delta_t, value_light_sensor);
    state_robot = robotSystem(state_robot, control_input, wheel, delta_t);
    drawRobot(state_robot, body, body_line);
    drawnow
end