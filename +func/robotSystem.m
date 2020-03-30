function q_next = robotSystem(q, u, wheel, delta_t)
    for i = 1:2
       if abs( u(i,1) ) > 1.0
           u(i,1) = sign(u(i,1)) * 1.0;
       end
    end
    Kv = [1000 0;0 990];     % motor constant value
    wheel_speed = Kv * u + 10*rand(2,1);         % dual wheel speed [v_right, v_left]
    L = vecnorm( wheel, 2, 2);
    theta_dot = wheel_speed(1,1)/L(1,1) - wheel_speed(2,1)/L(2,1);
    v = [1/2 1/2]*wheel_speed;
    q_next(1:2,1) = q(1:2,1) + v * [cos(q(3,1)); sin(q(3,1))] * delta_t;
    q_next(3,1) = q(3,1) + theta_dot * delta_t;
end