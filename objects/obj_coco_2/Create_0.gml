/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


start_sq();
start_colorise();

vel = 0.4;
velh = 0;
velv = 0;

state = "idle";

timer_idle = 0;
delay_idle = 60;

timer_walk = 0;
delay_walk = 60;
dir = 1;
inv = false;
inv_timer = 0;
inv_delay = 60;
hp = 5;
diff_dir = false;

timer_attack = 0;
delay_attack = game_get_speed(gamespeed_fps) / 3;

timer_shoot = 0;
delay_shoot = 60;

check_ground = function()
{
	tile = layer_tilemap_get_id("tl_ground");
	ground = place_meeting(x, y + 1, tile);
	not_ground = !place_meeting(x + sign(velh), y + 1, tile);
}

control_state = function()
{
	var _dist = point_distance(x, y, obj_player.x, obj_player.y);
	switch(state)
	{
		case "idle":
		{
			swap_sprite(spr_coco_2);
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
			
			if (_dist < 60 && y == obj_player.y)
			{
				state = "prepare_attack";
			}
		}
		break;
		case "walk":
		{
			swap_sprite(spr_coco_2_prepara_chifrada);
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
			
			if (velh != 0)
			{
				var _check_x = function()
				{
					if (velh > 0)
					{
						return bbox_right + 1;
					}
					else
					{
						return bbox_left - 1;
					}
				}
				if (!place_meeting(_check_x(), y + 1, tile))
				{
					velh = -velh;
				}
			}
			
			timer_walk++;
			
			if (timer_walk >= delay_walk)
			{
				timer_walk = 0;
				state = "idle";
			}
			
			if (_dist < 60)
			{
				state = "prepare_attack";
			}
		}
		break;
		case "prepare_attack":
		{
			diff_dir = true;
			swap_sprite(spr_coco_2_prepara_chifrada);
			velh = 0;
			//velv = 0;
			
			dir = sign(obj_player.x - x);
			
		}
		break;
		case "damage":
		{
			if (!inv)
			{
				inv = true;
				timer_colorise(5);
				use_sq(1.5, 0.5);
				
				if (hp > 1)
				{
					hp--;
					state = "idle";
				}
				else
				{
					instance_destroy();
				}
			}
		}
		break;
		case "attack":
		{
			swap_sprite(spr_coco_2_chifrada);
			velh = 2 * dir;
			
			timer_attack++;
			
			if (timer_attack >= delay_attack)
			{
				state = "idle";
				timer_attack = 0;
			}
		}
	}
}

swap_direction = function()
{
	if (!diff_dir)
	{
		if (velh != 0)
		{
			switch (sign(velh))
			{
				case 1:
				{
					dir = 1;
				}
				break;
				case -1:
				{
					dir = -1;
				}
			}
		}
	}
}