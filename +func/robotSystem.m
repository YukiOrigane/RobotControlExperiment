function q_next = robotSystem(q, u, wheel, delta_t, sysconf)
    persistent list_sp;
    persistent t filter filter_N;
    
    for i = 1:2
       if abs( u(i,1) ) > 1.0
           u(i,1) = sign(u(i,1)) * 1.0;
       end
    end
    Kv = [1000 0;0 990];     % motor constant value
    wheel_speed = Kv * u + ([[abs(u(1))>0.01, 0]; [abs(u(2))>0.01, 0]])*60*rand(2,1);         % dual wheel speed [v_right, v_left]
    
    L = vecnorm( wheel, 2, 2);
        
    % ���萔�}������
    if sysconf('time_constant') == "on"  % ���萔����
        time_constant = 0.1;
        if isempty(list_sp)   % ����
            t = 5*time_constant:-delta_t:0;
            filter = exp(-t/time_constant); % 1���n�C���p���X�����̔z��i�~���j
            filter_N = length(filter);
            list_sp = zeros(2,filter_N);
        end
        list_sp(:,1:filter_N-1) = list_sp(:,2:filter_N);  % ���͗����̍X�V
        list_sp(:,filter_N) = wheel_speed;  % 1���x��O��wheel_speed�𓊓�
        wheel_speed = (list_sp * filter.')/time_constant*delta_t;
        if sysconf('wheel_noise') == "on"   % �z�C�[���ɕ΃m�C�Y������
            wheel_speed = wheel_speed.*[1.0; 0.96];
        end
    end
    theta_dot = wheel_speed(1,1)/L(1,1) - wheel_speed(2,1)/L(2,1);
    v = [1/2 1/2]*wheel_speed;
    q_next(1:2,1) = q(1:2,1) + v * [cos(q(3,1)); sin(q(3,1))] * delta_t;
    q_next(3,1) = q(3,1) + theta_dot * delta_t;
end