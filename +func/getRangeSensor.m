function [val, detect_points] = getRangeSensor(q, list, wall)
    N = size(list,1);
    detect_points = zeros(2,N);
    field_size = size(wall);
    val = zeros(N,1);
    pos = [cos(q(3,1)) -sin(q(3,1)); sin(q(3,1)) cos(q(3,1))] * list(:,1:2).' + q(1:2,1)*ones(1,N);
    for i = 1:N
       detect_points(:,i) = [0; 0];
       direction = q(3,1) + list(i,3);
       for j = 1:3000  % max range is 3000mm
            pos(:,i) = pos(:,i) + [cos(direction); sin(direction)]; % 波の進行
            x = round(pos(1,i));
            y = round(pos(2,i));
            if x > field_size(1,1)-15 || x < 15 || y > field_size(1,2)-15 || y < 15 % 15mmは，傾き検出円のマージン
                detect_points(:,i) = [x; y];
                break; % 捜索範囲がフィールド超えた
            end
            if wall( x, y ) == 1
                detect_points(:,i) = [x; y];
                % 衝突角度の計算
                pre_flag_in = 0;
                for theta = 0:0.01:2*pi % 命中点の周りに半径12㎜の円周を展開
                    flag_in = wall(round(x+12*cos(theta)), round(y+12*sin(theta)));
                    if pre_flag_in == 1 && flag_in == 0 % 円周が壁から出た
                        theta_1 = theta;
                    end
                    if pre_flag_in == 0 && flag_in == 1 % 円周が壁に入った
                        theta_2 = theta;
                    end
                    pre_flag_in = flag_in;
                end
                theta_d = (theta_1 + theta_2 - pi)/2;   % 壁の傾きの計算
                if abs(theta_d) > pi
                    theta_d = sign(theta_d) * ( pi-abs(theta_d) );
                end
                if abs( pi/2 - abs(func.wrapPi(theta_d)-func.wrapPi(direction)) ) < pi/18 % 入射角<10°なら距離を渡す
                     val(i,1) = j + func.restrictedRandN(0, 0.01*j, 0.04*j);
                end
                break;
            end
       end
    end
    
    % val = val + 10 * randn; % ノイズ付与
    % disp(val)
end