/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (point_distance(x, y, obj_player.x, obj_player.y) < 40)
{
    box_alpha = lerp(box_alpha, 1, 0.1);
    
    if (index < string_length(texto) + 1)
    {
        index += vel_txt;
    }
}
else {
	box_alpha = lerp(box_alpha, 0, 0.1);
    if (index > 0)
    {
        index -= vel_txt;
    }
}

if (keyboard_check(vk_enter))
{
    vel_txt = .8;
}
else {
	vel_txt = .3;
}
