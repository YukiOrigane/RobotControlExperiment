
field_size = [3000, 1000];

drawInit(field_size);
field_line = setField(field_size);
imshow(field_line, 'DisplayRange', [0 255]);
field_line = field_line.';

state_robot = [200;500;0];  % gposX, gposY, gtheta
control_input = [0.0;0.0];    % dutyR, dutyL (-1.0 ~ +1.0, duty rate)

delta_t = 0.01;
N = 30000;
t = 0:delta_t:delta_t*(N-1);
t = t.';

body_line = line;

for k = 1:N
    if mod(k,5) == 0
        value_light_sensor = getLightSensor(state_robot, list_light_sensor, field_line);
        control_input = controller(t(k,1), delta_t, value_light_sensor);
    end
    state_robot = robotSystem(state_robot, control_input, wheel, delta_t);
    drawRobot(state_robot, body, body_line, list_light_sensor);
    pause(delta_t);
    drawnow
end