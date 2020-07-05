function makeVideo(file_name, M)
    disp("動画の出力を開始します");
    if isfolder('video') == 0
        mkdir('video');
    end
    v = VideoWriter(strcat('video/',file_name), 'MPEG-4');
    open(v);
    for i = 1:1:size(M,2)

            writeVideo(v,M(i));

    end
    close(v);
    disp("動画の出力が完了しました");
end