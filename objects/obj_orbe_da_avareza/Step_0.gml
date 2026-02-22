/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _tile = layer_tilemap_get_id("tl_ground")

if (place_meeting(x, y, _tile))
{
    state = "voltar";
}


if (state == "voltar")
{
    x = lerp(x, dest_x, 0.4);
    y = lerp(y, dest_y, 0.4);
    
    if (instance_exists(obj_player))
    {
        if (point_distance(x, y, obj_player.x, obj_player.y) < 10)
        {
            instance_destroy();
            obj_player.orb = true;
        }
    }
}