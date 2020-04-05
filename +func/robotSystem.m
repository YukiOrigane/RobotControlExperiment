function q_next = robotSystem(q, u, wheel, delta_t, time_constant)
    persistent list_sp; % �z�C�[���X�s�[�h�̗���
    persistent t filter filter_N;   % ��ݍ��ݕϐ��C�t�B���^�z��C�t�B���^�z�񒷂�
    persistent Kv wheel_N;  % ���[�^�萔�C�z�C�[����
    persistent J M;    % �������[�����g�C����
    
    if isempty(Kv)  % ����
        wheel_N = size(wheel,1);
        Kv = diag( 1000 + 5*(rand(1,wheel_N)-0.5) );   % �Ίp�s��C�e�Ίp�v�f�ɂ͂Ԃꍞ�ݒ萔�l����
        Kv(1:2,1:2) = [1000 0;0 997];     % �݊����̈ێ� ��ɏ��������H
        V_in = 0.1*(rand-0.5) + 1.0;    % �}5���̓d���d���덷
        Kv = Kv.*V_in;
        J = 100;
        M = 3;
    end
    
    for i = 1:wheel_N
       if abs( u(i,1) ) > 1.0
           u(i,1) = sign(u(i,1)) * 1.0;
       end
    end
    
    % wheel_speed = Kv * u + ([[abs(u(1))>0.01, 0]; [abs(u(2))>0.01, 0]])*10*rand(2,1);         % dual wheel speed [v_right, v_left]
    wheel_force = [cos(wheel(:,3).'); sin(wheel(:,3).')] * Kv * diag(u.');  % �e�z�C�[���̗̓x�N�g��
    % torque and force of each wheel have same dimision (assume radius of wheel is 1)
    robot_force = wheel_force * ones(wheel_N,1); % ���{�b�g�̗̓x�N�g��
    L = vecnorm(wheel(:,1:2),2,2).^(-1);
    wheel_force = wheel_force * diag(L);
    robot_momentum = [wheel(:,2).', -wheel(:,1).']*[wheel_force(1,:).'; wheel_force(2,:).'];    % ���{�b�g�S�̂̉�]���[�����g
    
    L = vecnorm( wheel, 2, 2);
        
    % ���萔�}������
    if exist('time_constant','var') == 1  % ���萔����
        if isempty(list_sp)   % ����
            t = 5*time_constant:-delta_t:0;
            filter = exp(-t/time_constant); % 1���n�C���p���X�����̔z��i�~���j
            filter_N = length(filter);
            list_sp = zeros(3,filter_N);
        end
        list_sp(:,1:filter_N-1) = list_sp(:,2:filter_N);  % ���͗����̍X�V
        list_sp(:,filter_N) = [robot_force./M; robot_momentum/J];  % 1���x��O��wheel_speed�𓊓�
        v = (list_sp(1:2,:) * filter.')/time_constant*delta_t;
        theta_dot = (list_sp(3,:) * filter.')/time_constant*delta_t;
    else
        theta_dot = robot_momentum / J;
        v = robot_force ./ M;
    end
    % theta_dot = wheel_speed(1,1)/L(1,1) - wheel_speed(2,1)/L(2,1);
    % v = [1/2 1/2]*wheel_speed;
    % q_next(1:2,1) = q(1:2,1) + v * [cos(q(3,1)); sin(q(3,1))] * delta_t;
    q_next(1:2,1) = q(1:2,1) + [cos(q(3,1)), -sin(q(3,1)); sin(q(3,1)), cos(q(3,1))] * v * delta_t;
    q_next(3,1) = q(3,1) + theta_dot * delta_t;
end