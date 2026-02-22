/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


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
throw_force = 2;
orb = true;
orb_dir = 0;
hitbox = noone;

#endregion variáveis


input = function()
{
    right = keyboard_check(vk_right) or keyboard_check(ord("D"));
    left = keyboard_check(vk_left) or keyboard_check(ord("A"));
    jump = keyboard_check_pressed(vk_space);
    dash = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(ord("C"));
    attack = mouse_check_button_pressed(mb_left) or keyboard_check_pressed(ord("Z"));
    attack2 = mouse_check_button_pressed(mb_right) or keyboard_check_pressed(ord("X"));
    
}

ground_check = function()
{
    //ground = place_meeting(x, y + 1, obj_collider);
    tile = layer_tilemap_get_id("tl_ground");
    ground = place_meeting(x, y + 1, tile);
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
        
        dash_counter = 0;
        
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
    
    if (dash && dash_duration == 0 && dash_counter == 0)
    {
        dash_duration = 10;
        dash_counter++;
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
    
    if (velh != 0) image_xscale = sign(velh);
    
    
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
        state = jump_state;
    }
    
    if (!ground)
    {
        state = jump_state;
    }
    
    if (dash)
    {
        state = dash_state;
    }
    
    if (attack && global.fragmento)
    {
        state = prepare_attack_state;
    }
    
    if (attack2 && global.fragmento && orb = true)
    {
        state = prepare_throw_state;
    }
}

move_state = function()
{
    apply_speed();
    swap_sprite(spr_player_walk);
    
    if (velh == 0)
    {
        state = idle_state;
    }
    
    if (jump)
    {
        state = jump_state;
    }
    
    if (dash)
    {
        state = dash_state;
    }
}

jump_state = function()
{
    apply_speed();
    
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
    }
    
    if (dash)
    {
        state = dash_state;
    }
}

dash_state = function()
{
    apply_speed();
    swap_sprite(spr_player_dash);
    
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
    }
}

prepare_throw_state = function()
{
    swap_sprite(spr_player_throw1);
    
    if (image_index >= image_number - 1)
    {
        var _input1 = mb_right;
        var _input2 = ord("X");
        if (mouse_check_button(_input1) or keyboard_check(_input2))
        {
            image_index = image_number - 1;
            throw_force += 0.1;
            
            if (mouse_check_button_released(_input1) or keyboard_check_released(_input2))
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
    
    if (image_index >= image_number - 1)
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
        
        throw_force = 2;
    }
}

prepare_attack_state = function()
{
    swap_sprite(spr_player_throw1);
    
    if (image_index >= image_number - 1)
    {
        state = attack_state;
    }
}

attack_state = function()
{
    swap_sprite(spr_player_attack);
    
    if (image_index >= 3)
    {
        if (hitbox == noone)
        {
            switch (image_xscale)
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
    }
}


state = idle_state;