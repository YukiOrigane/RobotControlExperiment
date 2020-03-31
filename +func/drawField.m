function drawField(field_size, line, wall, finish_zone)

field_image = cat(3,line,line,line);
field_image(:,:,1) = field_image(:,:,1) - wall.*100;
field_image(:,:,2) = field_image(:,:,2) - wall.*200;
field_image(:,:,3) = field_image(:,:,3) - wall.*200;

for i=1:field_size(1)
    for j = 1:field_size(2)
        if norm([i-finish_zone(1,1),j-finish_zone(2,1)]) < finish_zone(3,1) && norm([i-finish_zone(1,1),j-finish_zone(2,1)]) > finish_zone(3,1)-5
            if finish_zone(4,1) == 0
                field_image(j, i, :) = [0, 100, 250];
            else
                field_image(j, i, :) = [0, 200, 100];
            end
        end
    end
end

field_image = rescale(field_image);
imshow(field_image);

end