function check = checkRobotPosition(q, body, field_size, wall)
    check = 1;
    theta = q(3,1);
    gpos_point = round( [cos(theta) -sin(theta); sin(theta) cos(theta)] * [body; body(1,:)].' + q(1:2,1)*ones(1,5) );
    gpos_point(:,5) = round( q(1:2,1) );
    for i=1:5
        x = gpos_point(1,i);
        y = gpos_point(2,i);
        if x<1 || y<1 || x>field_size(1,1) || y>field_size(1,2)
            check = -1;
            break
        end
        if wall(x,y) == 1
            check = -1;
            break;
        end
    end
    if check == -1
        disp("ロボットがフィールド外に出たか，壁と接触しました");
    end
end