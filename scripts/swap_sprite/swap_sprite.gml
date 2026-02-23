// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


/// Funçao para trocar a sprite e colocar no frame inicial
/// @param sprite       A sprite que deseja que o objeto (player) troque
function swap_sprite(_sprite){
    if (sprite_index != _sprite)
    {
        image_index = 0;
        sprite_index = _sprite;
    }
}

/// Funçao para trocar a sprite e colocar no frame final (para animacoes invertidas)
/// @param sprite       A sprite que deseja que o objeto (player) troque
function swap_sprite_reversed(_sprite){
    if (sprite_index != _sprite)
    {
        image_index = sprite_get_number(_sprite) - 1;
        sprite_index = _sprite;
    }
}