system_config('time_constant') = "off"; % 1���x��n�i�����R���j�̎��萔 0�œK�p����
system_config('wheel_noise') = "off";   % �z�C�[���o�͂ɕ΂����m�C�Y�����邩�ۂ�
system_config('add_wheel') = "off"; % �Ɨ���ֈȊO���g�p���邩�ۂ�

if exist('system_lebel','var')
    switch system_lebel
        case 0  % �S���I�t
        case 1
            system_config('time_constant') = "on";
        case 2
            system_config('time_constant') = "on";
            system_config('wheel_noise') = "on";
    end
end



