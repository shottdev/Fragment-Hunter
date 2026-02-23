/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (instance_exists(obj_player))
{
    var _p = instance_nearest(x, y, obj_player);
}

if (!global.teleporting)
{
    image_alpha -= 0.1;
}

if (image_alpha <= 0) instance_destroy();