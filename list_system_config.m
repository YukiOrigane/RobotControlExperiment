system_config('time_constant') = "off"; % 1���x��n�i�����R���j�̎��萔 0�œK�p����
system_config('wheel_noise') = "off";   % �z�C�[���ɕ΃m�C�Y���悹�邩�ۂ�
system_config('add_wheel') = "off"; % �Ɨ���ֈȊO���g�p���邩�ۂ�

if exist('system_lebel','var')
    switch system_lebel
        case 0  % �S���I�t
        case 1
            system_config('time_constant') = 0.1;
        case 2
            system_config('time_constant') = 0.1;
            system_config('wheel_noise') = "on";
    end
end



