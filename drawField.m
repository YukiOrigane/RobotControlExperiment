function drawField(size, line, wall)

field_image = cat(3,line,line,line);
field_image(:,:,1) = field_image(:,:,1) - wall.*100;
field_image(:,:,2) = field_image(:,:,2) - wall.*200;
field_image(:,:,3) = field_image(:,:,3) - wall.*200;
field_image = rescale(field_image);
imshow(field_image);

end