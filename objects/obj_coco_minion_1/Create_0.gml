/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


vel = 0.7;
velh = 0;
velv = 0;

state = "idle";

timer_idle = 0;
delay_idle = 60;

timer_walk = 0;
delay_walk = 60;

check_ground = function()
{
	tile = layer_tilemap_get_id("tl_ground");
	ground = place_meeting(x, y + 1, tile);
}

control_state = function()
{
	var _dist = point_distance(x, y, obj_player.x, obj_player.y);
	switch(state)
	{
		case "idle":
		{
			velh = 0;
			velv = 0;
			
			timer_idle++;
			
			if (timer_idle >= delay_idle)
			{
				state = "walk";
				timer_idle = 0;
				velh = vel * irandom_range(-1, 1);
				delay_idle = random_range(60, 120);
			}
			
			if (_dist < 30)
			{
				state = "shoot";
			}
		}
		break;
		case "walk":
		{
			rigth = 1;
			left = -1;
			
			if (ground)
			{
				velv = 0;
			}
			else
			{
				velv += 0.2;
			}
			
			if (place_meeting(x + velh, y, tile))
			{
				velh = -velh;
			}
			
			timer_walk++;
			
			if (timer_walk >= delay_walk)
			{
				timer_walk = 0;
				state = "idle";
			}
			
			if (_dist < 30)
			{
				state = "shoot";
			}
		}
		break;
		case "shoot":
		{
			velh = 0;
			velv = 0;
			
		}
	}
}