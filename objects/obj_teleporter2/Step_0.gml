/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (instance_exists(obj_player))
{
    var _p = instance_nearest(x, y, obj_player);
    
    if (!global.teleporting)
    {
        image_alpha -= 0.05;
        image_xscale -= 0.05;
        image_yscale += 0.02;
    }
    else {
    	_p.x = x;
    }
}

if (image_alpha <= 0) instance_destroy();