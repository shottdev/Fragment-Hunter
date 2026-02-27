/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor



velh = 0;
velv = 0;

state = "parado";
timer_decidir = 0;
delay_decidir = game_get_speed(gamespeed_fps);

state_machine = function()
{
	randomise();
	switch (state)
	{
		case "parado":
		{
			timer_decidir++;
			velh = 0;
		
			if (timer_decidir >= delay_decidir)
			{
				velh = choose(0.7, -0.7);
				state = "andando";
				timer_decidir = 0;
			}
		}
		break;
		case "andando":
		{
			timer_decidir++;
			x += velh;
			
			image_xscale = sign(velh);
		
			if (timer_decidir >= delay_decidir)
			{
				state = choose("andando", "parado");
				timer_decidir = 0;
			}
			
			var _tile = layer_tilemap_get_id("tl_ground");
			var _ground = place_meeting(x, y + 1, _tile);
			var _wall = place_meeting(x + velh, y, _tile);
			var _next_ground = place_meeting(x + velh, y + 1, _tile);
			
			if (_wall or !_next_ground)
			{
				state = "parado";
			}
			
			if (instance_exists(obj_player))
			{
				if (point_distance(x, y, obj_player.x, obj_player.y) < 30 && state != "atirando")
				{
					state = "atirando";	
				}
			}
		}
		break;
		case "atirando":
		{
			velh = 0;
			
			if (instance_exists(obj_player))
			{
				if (point_distance(x, y, obj_player.x, obj_player.y) > 50)
				{
					state = "parado";	
				}
			}
		}
		break;
	}
	
	show_debug_message(state);
}