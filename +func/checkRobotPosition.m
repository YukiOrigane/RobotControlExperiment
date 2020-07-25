function check = checkRobotPosition(q, body, field_size, wall, finish_zone)
    check = 1;
    theta = q(3,1);
    persistent pre_q;
    if isempty(pre_q)
        pre_q = [0; 0; 0];
    end
    in_finish_zone = 0;
    gpos_point = round( [cos(theta) -sin(theta); sin(theta) cos(theta)] * [body; body(1,:)].' + q(1:2,1)*ones(1,5) );
    gpos_point(:,5) = round( q(1:2,1) );

    for i = 1:5
        x = gpos_point(1,i);
        y = gpos_point(2,i);
        if x < 1 || y < 1 || x > field_size(1,1) || y > field_size(1,2)
            check = -1;
            disp("ロボットがフィールド外に出ました");
            break
        elseif wall(x,y) == 1
            check = -1;
            disp("ロボットが壁に衝突しました");
            break;
        end

        if vecnorm([x;y] - finish_zone(1:2,1)) < finish_zone(3,1)
            in_finish_zone = in_finish_zone + 1;
        end
    end

    if in_finish_zone == 5
        if finish_zone(4,1) == 0    % 侵入でOK
            disp("ロボットが終了エリアに入りました");
            check = -1;
        elseif pre_q == q           % 静止を要求
            disp("ロボットが終了エリアで停止しました");
            check = -1;
        end
        pre_q = q;
    end
end
