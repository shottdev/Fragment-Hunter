/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _tile = layer_tilemap_get_id("tl_ground")

if (place_meeting(x, y, _tile))
{
    state = "voltar";
}


if (state == "ir")
{
    var _amount = 0.05;
    
    _amount += 0.05;
    y += _amount;
}

if (state == "voltar")
{
    
    if (instance_exists(obj_player))
    {
        
        direction = point_direction(x, y, obj_player.x, obj_player.y - 8);
        if (point_distance(x, y, obj_player.x, obj_player.y) < 10)
        {
            instance_destroy();
            obj_player.orb = true;
        }
    }
}