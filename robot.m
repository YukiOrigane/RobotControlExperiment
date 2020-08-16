
init_state = [200; 500; 0]; % ロボットの初期状態 [ posx; posy; theta ];

body = [100 150; -100 100; -100 -100; 100 -150];
wheel = [0 125; 0 -125];

list_light_sensor = ones(2,5)*100;
list_light_sensor(2,:) = 30:10:70;   % センサ5つ
list_light_sensor = list_light_sensor.';
list_range_sensor = [100 0 0;];

range_line_visible = 'off';
is_light_sensor_visible = true;

system_lebel = 1;   % システムのリアル度を変更
