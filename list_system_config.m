system_config('time_constant') = "off"; % 1次遅れ系（慣性由来）の時定数 0で適用せず
system_config('wheel_noise') = "off";   % ホイール出力に偏ったノイズを入れるか否か
system_config('add_wheel') = "off"; % 独立二輪以外を使用するか否か

if exist('system_lebel','var')
    switch system_lebel
        case 0  % 全部オフ
        case 1
            system_config('time_constant') = "on";
        case 2
            system_config('time_constant') = "on";
            system_config('wheel_noise') = "on";
    end
end
