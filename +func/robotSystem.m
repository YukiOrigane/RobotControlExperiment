function q_next = robotSystem(q, u, wheel, delta_t, time_constant, viscosity)
    persistent list_sp;
    persistent t filter filter_N;
    
    if exist('viscosity','var') == 0   % 時定数が空で渡されたら0
        viscocity = 0;
    end
    
    for i = 1:2
       if abs( u(i,1) ) > 1.0
           u(i,1) = sign(u(i,1)) * 1.0;
       end
    end
    Kv = [1000 0;0 990];     % motor constant value
    wheel_speed = Kv * u + ([[abs(u(1))>0.01, 0]; [abs(u(2))>0.01, 0]])*60*rand(2,1);         % dual wheel speed [v_right, v_left]
    L = vecnorm( wheel, 2, 2);
        
    % 時定数挿入処理
    if exist('time_constant','var') == 1  % 時定数あり
        if isempty(list_sp)   % 一回目
            t = 5*time_constant:-delta_t:0;
            filter = exp(-t/time_constant); % 1次系インパルス応答の配列（降順）
            filter_N = length(filter);
            list_sp = zeros(2,filter_N);
        end
        list_sp(:,1:filter_N-1) = list_sp(:,2:filter_N);  % 入力履歴の更新
        list_sp(:,filter_N) = wheel_speed;  % 1次遅れ前のwheel_speedを投入
        wheel_speed = (list_sp * filter.')/time_constant*delta_t;
    end
    theta_dot = wheel_speed(1,1)/L(1,1) - wheel_speed(2,1)/L(2,1) + viscosity;
    v = [1/2 1/2]*wheel_speed;
    q_next(1:2,1) = q(1:2,1) + v * [cos(q(3,1)); sin(q(3,1))] * delta_t;
    q_next(3,1) = q(3,1) + theta_dot * delta_t;
end