system_config('time_constant') = "off"; % 1���x��n�i�����R���j�̎��萔 0�œK�p����
system_config('friction_force') = "off";   % �z�C�[���o�͂ɖ��C��R�����邩�ۂ�
system_config('add_wheel') = "off"; % �Ɨ���ֈȊO���g�p���邩�ۂ�

if exist('system_lebel','var')
    switch system_lebel
        case 0  % �S���I�t
        case 1
            system_config('time_constant') = "on";
        case 2
            system_config('time_constant') = "on";
            system_config('friction_force') = "on";
    end
end



