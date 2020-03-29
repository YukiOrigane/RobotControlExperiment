function [val, detect_points] = getRangeSensor(q, list, wall)
    N = size(list,1);
    detect_points = zeros(2,N);
    field_size = size(wall);
    val = zeros(N,1);
    pos = [cos(q(3,1)) -sin(q(3,1)); sin(q(3,1)) cos(q(3,1))] * list(:,1:2).' + q(1:2,1)*ones(1,N);
    for i = 1:N
       detect_points(:,i) = zeros(2,1);
       direction = q(3,1) + list(i,3);
       for j = 1:3000  % max range is 3000mm
            pos(:,i) = pos(:,i) + [cos(direction); sin(direction)]; % ”g‚Ìis
            x = round(pos(1,i));
            y = round(pos(2,i));
            if x > field_size(1,1)-15 || x < 15 || y > field_size(1,2)-15 || y < 15 % 15mm‚ÍCŒX‚«ŒŸo‰~‚Ìƒ}[ƒWƒ“
                detect_points(:,i) = [x; y];
                break; % ‘{õ”ÍˆÍ‚ªƒtƒB[ƒ‹ƒh’´‚¦‚½
            end
            if wall( x, y ) == 1
                detect_points(:,i) = [x; y];
                % Õ“ËŠp“x‚ÌŒvŽZ
                pre_flag_in = 0;
                for theta = 0:0.01:2*pi % –½’†“_‚ÌŽü‚è‚É”¼Œa12‡o‚Ì‰~Žü‚ð“WŠJ
                    flag_in = wall(round(x+12*cos(theta)), round(y+12*sin(theta)));
                    if pre_flag_in == 1 && flag_in == 0 % ‰~Žü‚ª•Ç‚©‚ço‚½
                        theta_1 = theta;
                    end
                    if pre_flag_in == 0 && flag_in == 1 % ‰~Žü‚ª•Ç‚É“ü‚Á‚½
                        theta_2 = theta;
                    end
                    pre_flag_in = flag_in;
                end
                theta_d = (theta_1 + theta_2 - pi)/2;   % •Ç‚ÌŒX‚«‚ÌŒvŽZ
                if abs(theta_d) > pi
                    theta_d = sign(theta_d) * ( pi-abs(theta_d) );
                end
                if abs( pi/2 - abs(theta_d-direction) ) < pi/18 % “üŽËŠp<10‹‚È‚ç‹——£‚ð“n‚·
                     val(i,1) = j + restrictedRandN(0, 0.01*j, 0.04*j);
                end
                break;
            end
       end
    end
    
    % val = val + 10 * randn; % ƒmƒCƒY•t—^
    % disp(val)
end