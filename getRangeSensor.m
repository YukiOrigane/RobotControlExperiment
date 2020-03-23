function val = getRangeSensor(q, list, wall)
    N = size(list,1);
    field_size = size(wall);
    val = zeros(N,1);
    pos = [cos(q(3,1)) -sin(q(3,1)); sin(q(3,1)) cos(q(3,1))] * list(:,1:2).' + q(1:2,1)*ones(1,N);
    for i = 1:N
       direction = q(3,1) + list(i,3);
       for j = 1:3000  % max range is 3000mm
            pos(:,i) = pos(:,i) + [cos(direction); sin(direction)]; % ”g‚Ìis
            x = round(pos(1,i));
            y = round(pos(2,i));
            if x > field_size(1,1) || x < 0 || y > field_size(1,2) || y < 0
                break; % ‘{õ”ÍˆÍ‚ªƒtƒB[ƒ‹ƒh’´‚¦‚½
            end
            if wall( x, y ) == 1
                if wall(x+1, y)*wall(x-1,y) == 0    % xŽ²‚É‚’¼‚È•Ç
                    if abs(direction)<pi/18 || abs(direction)>17*pi/18  % “üŽËŠp < ŽU•zŠp
                        val(i,1) = j;
                    end
                elseif wall(x, y+1)*wall(x,y-1) == 0    % yŽ²‚É‚’¼‚È•Ç
                        val(i,1) = jn;
                else    % •ª‚©‚ç‚¸
                end
                break;
            end
       end
    end
    % val = val + 10 * randn; % ƒmƒCƒY•t—^
    disp(val)
end