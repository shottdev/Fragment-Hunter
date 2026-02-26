/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


start_colorise();

inv = false;
timer_inv = 0;
delay_inv = 30;
velh = 0.4;

normal = function()
{
    if (inv == true)
    {
        timer_inv++;
        if (timer_inv >= delay_inv)
        {
            inv = false;
            timer_inv = 0;
        }
    }
    else {
        var _tile = layer_tilemap_get_id("tl_ground");
        if (velh < 0) var _fim = !place_meeting(x + (sign(velh) * (sprite_width / 2)), y + 1, _tile) or place_meeting(x + velh, y, _tile);
        if (velh > 0) var _fim = !place_meeting(x - (sign(velh) * (sprite_width / 2)), y + 1, _tile) or place_meeting(x + velh, y, _tile);
        
        if (_fim)
        {
            velh = -velh;
        }
        
        x += velh;
    }
}
damage = function()
{
    if (!inv)
    {
        timer_colorise(5);
        inv = true;
    }
    
    
    state = normal;
}

state = normal;