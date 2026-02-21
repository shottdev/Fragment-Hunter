/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


input();
ground_check();
move();

state();

if (velh != 0) image_xscale = sign(velh);
    
switch (sign(velh))
{
    case -1:
    {
        dash_dir = -1;
    }
        break;
    case 1:
    {
        dash_dir = 1;
    }
        break;
}

if (dash_duration > 0)
{
    timer_afterimage++;
    
    if (timer_afterimage >= delay_afterimage)
    {
        var _phantom = instance_create_layer(x, y, "Instances", obj_player_afterimage);
        _phantom.sprite_index = sprite_index;
        _phantom.image_index = image_index;
        _phantom.image_xscale = image_xscale;
        timer_afterimage = 0;
    }
}