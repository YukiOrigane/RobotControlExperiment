% 範囲制限付き正規分布を返す
% @oaram nu : 平均値
% @param sigma：標準偏差
% @range 範囲を-range ~ rangeに制限
function y = restrictedRandN(nu, sigma, range)
while 1
    y = sigma * randn + nu;
    if abs(y-nu) <= range
        break;
    end
end
end
