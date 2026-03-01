/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


start_colorise();

inv = false;
timer_inv = 0;
delay_inv = 30;
velh = 0.4;
hp = 3;

start_sq(1, 1);

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
            image_xscale = -image_xscale;
        }
        
        x += velh;
    }
    
    var _target_xscale = 1 * sign(velh); // estica horizontal
    adjust_sq(_target_xscale, 1, 0.1);
    
    image_xscale = sq_xscale;
    image_yscale = sq_yscale;
}
damage = function()
{
    if (!inv)
    {
        timer_colorise(5);
        inv = true;
		
		if (hp == 1)
		{
			instance_destroy();
		}
		else
		{
			hp--;
		}
    }
    
    var _target_xscale = 1.4 * sign(velh);
    var _target_yscale = 0.6;
    use_sq(_target_xscale, _target_yscale);
    //hp--;
	
    state = normal;
}

state = normal;