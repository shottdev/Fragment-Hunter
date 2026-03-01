/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


check_ground();
if (instance_exists(obj_player)) control_state();

move_and_collide(velh, 0, tile);
move_and_collide(0, velv, tile);

counter_colorise();
adjust_sq();
swap_direction();

if (inv)
{
	inv_timer++;
	
	if (inv_timer >= inv_delay)
	{
		inv_timer = 0;
		inv = false;
	}
}