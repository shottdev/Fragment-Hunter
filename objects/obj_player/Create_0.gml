/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


velh = 0;
max_velh = 1.5;
velv = 0;
max_velv = 3;
grav = .2;
jump_counter = 0;


input = function()
{
    right = keyboard_check(vk_right) or keyboard_check(ord("D"));
    left = keyboard_check(vk_left) or keyboard_check(ord("A"));
    jump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_up);
}

ground_check = function()
{
    ground = place_meeting(x, y + 1, obj_collider);
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
    }
    else {
        if (jump && jump_counter < 2)
        {
            velv = -(max_velv + 0.4); 
            jump_counter++;
        }
        else {
    	    velv += grav;
        }
            
        if (place_meeting(x, y - 1, obj_collider) && velv < 0)
        {
            velv = 0;
        }
    }
}

apply_speed = function()
{
    move_and_collide(velh, 0, obj_collider, 12);
    move_and_collide(0, velv, obj_collider, 24);
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