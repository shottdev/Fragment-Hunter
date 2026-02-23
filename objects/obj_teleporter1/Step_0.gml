/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (instance_exists(obj_player))
{
    var _p = instance_nearest(x, y, obj_player)
    
    if (point_distance(x, y, _p.x, _p.y) <= 5 && _p.ground == true)
    {
        _p.x = x;
        _p.y = y;
        
        _p.state = _p.falling_state;
        
        global.teleporting = true;
    }
}

if (image_xscale <= 0) instance_destroy();