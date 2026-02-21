/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


velh = 0;
max_velh = 2;
velv = 0;
max_velv = 2.5;
grav = .2;


input = function()
{
    right = keyboard_check(vk_right) or keyboard_check(ord("A"));
    left = keyboard_check(vk_left) or keyboard_check(ord("D"));
    jump = keyboard_check(vk_space) or keyboard_check(vk_up) or keyboard_check(ord("W"));
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
        velv = 0;
        
        if (jump)
        {
            velv = -max_velv
        }
    }
    else {
    	velv += grav;
    }
}

apply_speed = function()
{
    move_and_collide(velh, 0, obj_collider, 12);
    move_and_collide(0, velv, obj_collider, 24);
}