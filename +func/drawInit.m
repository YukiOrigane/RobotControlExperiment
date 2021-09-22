function drawInit(ax, field_size)
xlim(ax, [0 field_size(1,1)])
ylim(ax, [0 field_size(1,2)])
daspect(ax, [1 1 1]);
end
