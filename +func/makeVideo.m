function makeVideo(file_name, M)
    disp("����̏o�͂��J�n���܂�");
    if isfolder('video') == 0
        mkdir('video');
    end
    v = VideoWriter(strcat('video/',file_name), 'MPEG-4');
    open(v);
    for i = 1:1:size(M,2)

            writeVideo(v,M(i));

    end
    close(v);
    disp("����̏o�͂��������܂���");
end