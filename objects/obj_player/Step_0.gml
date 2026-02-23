/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


input();
ground_check();
move();

state();

    
switch (sign(velh))
{
    case -1:
    {
        dash_dir = -1;
        orb_dir = 180
    }
        break;
    case 1:
    {
        dash_dir = 1;
        orb_dir = 0;
    }
        break;
}

if (dash_duration > 0)
{
    timer_afterimage++;
    
    if (timer_afterimage >= delay_afterimage)
    {
        var _phantom = instance_create_layer(x, y, "player", obj_player_afterimage);
        _phantom.sprite_index = sprite_index;
        _phantom.image_index = image_index;
        _phantom.image_xscale = image_xscale;
        timer_afterimage = 0;
    }
}

throw_force = clamp(throw_force, 3, 5);


if (!orb)
{
    obj_orbe_da_avareza.dest_x = x;
    obj_orbe_da_avareza.dest_y = y - 8;
}