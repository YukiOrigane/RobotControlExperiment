function val = getLightSensor(q, list, line, noise)
N = size(list,1);
val = zeros(N,1);
pos = [cos(q(3,1)) -sin(q(3,1)); sin(q(3,1)) cos(q(3,1))] * list.' + q(1:2,1)*ones(1,N);
pos = round(pos);
for i = 1:N
    val(i,1) = line(pos(1,i), pos(2,i));
    val(i,1) = val(i,1) + func.restrictedRandN(0, 8, 24);  % randam noise
    val(i,1) = val(i,1) + noise;    % environmental noise (static)
    if val(i,1) > 300
        val(i,1) = 300;
    elseif val(i,1) < 0
        val(i,1) = 0;
    end
end
end
