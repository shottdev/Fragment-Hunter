/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


start_sq();

#region variáveis
#region andar
//velocidade horizontal
velh = 0;
//velocidade máxima horizontal (velocidade que ele se move)
max_velh = 1;
#endregion andar

#region pulo e gravidade
//velocidade vertical
velv = 0;
//velocidade máxima vertical (força do pulo)
max_velv = 3;
//gravidade
grav = .2;
//contador de pulos
jump_counter = 0;
#endregion pulo e gravidade

#region dash
//duraçao do dash (em frames)
dash_duration = 0;
//direçao do dash (1 - frente, -1 - trás)
dash_dir = 1;
//velocidade do dash
dash_speed = 5;

//timer do afterimage
timer_afterimage = 0;
//delay afterimage
delay_afterimage = 2;

//contador de dash
dash_counter = 0;
#endregion dash

seq_id = -1;
throw_force = 3;
orb = true;
orb_dir = 0;
hitbox = noone;
kb_duration = 10;

dash_timer = 0;
delay_dash = 20;

can_dash = true;

dir = 1;

lock_dir = false;

#endregion variáveis


input = function()
{
    right = keyboard_check(vk_right) or keyboard_check(ord("D")) or gamepad_axis_value(global.gamepad_id, gp_axislh) > 0.25 or gamepad_button_check(global.gamepad_id, gp_padr);
    left = keyboard_check(vk_left) or keyboard_check(ord("A")) or gamepad_axis_value(global.gamepad_id, gp_axislh) < -0.25 or gamepad_button_check(global.gamepad_id, gp_padl);
    jump = keyboard_check_pressed(vk_space) or gamepad_button_check_pressed(global.gamepad_id, gp_face1);
    dash = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(ord("C")) or gamepad_button_check_pressed(global.gamepad_id, gp_shoulderrb);
    attack = mouse_check_button_pressed(mb_left) or keyboard_check_pressed(ord("Z")) or gamepad_button_check_pressed(global.gamepad_id, gp_face3);
    attack2 = mouse_check_button_pressed(mb_right) or keyboard_check_pressed(ord("X")) or gamepad_button_check_pressed(global.gamepad_id, gp_face2);
	attack2_down = mouse_check_button(mb_right) or keyboard_check(ord("X")) or gamepad_button_check(global.gamepad_id, gp_face2);
	attack2_release = mouse_check_button_released(mb_right) or keyboard_check_released(ord("X")) or gamepad_button_check_released(global.gamepad_id, gp_face2);
    
}

ground_check = function()
{
    //ground = place_meeting(x, y + 1, obj_collider);
    tile = layer_tilemap_get_id("tl_ground");
    ground = place_meeting(x, y + 1, tile);
}

swap_direction = function()
{
	//nao faz mais nada
	if (!lock_dir)
	{
		if (right) dir = 1;
		if (left) dir = -1;
	}
}

move = function()
{
    velh = (right - left) * max_velh;
    
    if (ground)
    {
        jump_counter = 0;
        velv = 0;
        y = round(y);
        
        if (jump)
        {
            velv = -max_velv;
            jump_counter++;
        }
        
		if (can_dash) dash_counter = 0;
    }
    else {
        if (jump_counter == 0) jump_counter = 1;
        if (jump && jump_counter < 2)
        {
            velv = -(max_velv + 0.4); 
            jump_counter++;
        }
        else {
    	    velv += grav;
        }
            
        if (place_meeting(x, y - 1, tile) && velv < 0)
        {
            velv = 0;
        }
    }
    
    if (dash && dash_duration == 0 && dash_counter == 0 && can_dash == true)
    {
        dash_duration = 10;
        dash_counter++;
		can_dash = false;
    }
    
    if (dash_duration > 0)
    {
        var _vel = dash_speed * dash_dir;
        dash_duration--;
        
        if (!place_meeting(x + _vel, y, tile))
        {
            velh = _vel;
            velv = 0;
        }
        else {
        	velh = 0;
            dash_duration = 0;
        }
    }
	
	if (dash_counter > 0 && can_dash == false)
	{
		dash_timer++;
			
		if (dash_timer >= delay_dash)
		{
			can_dash = true;
			dash_timer = 0;
		}
	}
    
    
    if (place_meeting(x + velh, y, obj_collider))
    {
        velh = 0;
    }
}

apply_speed = function()
{
    move_and_collide(velh, 0, tile, 24);
    move_and_collide(0, velv, tile, 24);
        
}


idle_state = function()
{
    apply_speed();
    swap_sprite(spr_player_idle);
    
    if (right != left)
    {
        state = move_state;
    }
    
    if (jump)
    {
		instance_create_depth(x, y + 3, depth - 1, obj_pulo_particula);
        state = jump_state;
		use_sq(0.6, 1.4);
    }
    
    if (!ground)
    {
        state = jump_state;
    }
    
    if (dash && !can_dash)
    {
        state = dash_state;
		use_sq(1.4, 0.6);
    }
    
    if (attack && global.fragmento && orb == true)
    {
        state = prepare_attack_state;
    }
    
    if (attack2 && global.fragmento && orb == true)
    {
        state = prepare_throw_state;
    }
    
    if (global.teleporting)
    {
        state = returning_state;
    }
}

move_state = function()
{
    apply_speed();
    swap_sprite(spr_player_walk);
    swap_direction();
    
    if (velh == 0)
    {
        state = idle_state;
    }
    
    if (jump)
    {
		instance_create_depth(x, y + 3, depth - 1, obj_pulo_particula);
        state = jump_state;
		use_sq(0.6, 1.4);
    }
    
    if (dash && !can_dash)
    {
        state = dash_state;
		use_sq(1.4, 0.6);
    }
    
    if (!ground)
    {
        state = jump_state;
    }
}

jump_state = function()
{
    apply_speed();
    swap_direction();
    
    if (velv < 0)
    {
        swap_sprite(spr_player_jump_up);
    }
    if (velv > 0) {
    	swap_sprite(spr_player_jump_down);
    }
    
    if (ground)
    {
        state = idle_state;
		use_sq(1.5, 0.5);
		instance_create_depth(x, y, depth - 1, obj_pouso_particula);
    }
    
    if (dash && !can_dash)
    {
        state = dash_state;
		use_sq(1.4, 0.6);
    }
	
	if (jump && jump_counter < 2)
	{
		use_sq(0.5, 1.5);
	}
}

dash_state = function()
{
    apply_speed();
    swap_sprite(spr_player_dash);
    swap_direction();
    
    if (dash_duration <= 0)
    {
        state = idle_state;
    }
}

fragment_pickup_state = function()
{
    var _view_w = camera_get_view_width(view_camera[0]);
    var _view_h = camera_get_view_height(view_camera[0]);
    
    global.fragmento = true;
    
    var _target_w = 145;
    var _target_h = 75;
    
    _view_w = lerp(_view_w, _target_w, 0.1);
    _view_h = lerp(_view_h, _target_h, 0.1);
    
    camera_set_view_size(view_camera[0], _view_w, _view_h);
    
    if (_view_w <= 147 && !layer_sequence_exists("sq_transicao", seq_id))
    {
        seq_id = layer_sequence_create("sq_transicao", 0, 0, sq_transition1);
        global.destino = rm_fase_teste;
		global.transicao = true;
    }
}

prepare_throw_state = function()
{
    swap_sprite(spr_player_throw1);
    
    if (image_index >= image_number - 1)
    {
        if (attack2_down)
        {
            image_index = image_number - 1;
            throw_force += 0.1;
            
            if (attack2_release)
            {
                state = throw_state;
            }
        }
        else {
        	state = throw_state;
        }
    }
}

throw_state = function()
{
    swap_sprite(spr_player_throw2);
    
    if (image_index >= 4)
    {
        var _orb = instance_create_layer(x, y - 8, "items", obj_orbe_da_avareza);
        _orb.speed = throw_force;
        _orb.direction = orb_dir;
        _orb.image_xscale = 1;
        _orb.image_yscale = 1;
        //_orb.delay = 60 * 1.5;
        //_orb.force = throw_force + 0.8;
        orb = false;
        
        state = idle_state;
        
        throw_force = 3;
    }
}

prepare_attack_state = function()
{
	lock_dir = true;
    swap_sprite(spr_player_throw1);
    
    if (image_index >= image_number - 1)
    {
        state = attack_state;
    }
}

attack_state = function()
{
	swap_direction();
    swap_sprite(spr_player_attack);
	
    if (image_index >= 3)
    {
        if (hitbox == noone)
        {
            switch (dir)
            {
                case 1:
                {
                    hitbox = instance_create_layer(x + 12, y, "misc", obj_hitbox);
                }
                    break;
                case -1:
                {
                    hitbox = instance_create_layer(x - 12, y, "misc", obj_hitbox);
                }
            }
        }
        
        //if (image_number >= 9)
        //{
            //if (instance_exists(_hitbox))
            //{
                //instance_destroy(_hitbox);
            //}
        //}
    }
    
    
    if (image_index >= image_number - 1)
    {
        if (hitbox != noone)
        {
            instance_destroy(hitbox);
            hitbox = noone;
        }
        state = idle_state;
		lock_dir = false;
    }
}


falling_state = function()
{
    swap_sprite(spr_player_falling);
    
    if (image_index >= image_number - 1)
    {
        room_goto(global.tp_destiny);
    }
}

returning_state = function()
{
    swap_sprite_reversed(spr_player_falling);
    
    if (image_index <= 1)
    {
        state = idle_state;
        global.teleporting = false;
    }
}


if (global.teleporting && instance_number(obj_teleporter2) == 0)
{
    instance_create_layer(x, y, "teleporter", obj_teleporter2);
}

if (global.transicao == true)
{
	var _transicao2 = noone;
	if (!layer_sequence_exists("sq_transicao", _transicao2))
	{
		_transicao2 = layer_sequence_create("sq_transicao", 0, 0, sq_transition2);
	}
}


state = idle_state;