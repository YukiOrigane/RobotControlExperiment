% �͈͐����t�����K���z��Ԃ�
% @oaram nu : ���ϒl
% @param sigma�F�W���΍�
% @range �͈͂�-range ~ range�ɐ���
function y = restrictedRandN(nu, sigma, range)
    while 1
        y = sigma*randn + nu;
        if abs(y-nu)<=range
            break;
        end
    end
end