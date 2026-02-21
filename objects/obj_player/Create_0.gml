/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


#region variáveis
#region andar
//velocidade horizontal
velh = 0;
//velocidade máxima horizontal (velocidade que ele se move)
max_velh = 1.5;
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

#endregion variáveis


input = function()
{
    right = keyboard_check(vk_right) or keyboard_check(ord("D"));
    left = keyboard_check(vk_left) or keyboard_check(ord("A"));
    jump = keyboard_check_pressed(vk_space);
    dash = keyboard_check_pressed(vk_shift);
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
}


state = idle_state;