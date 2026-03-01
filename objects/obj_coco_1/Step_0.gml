/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


check_ground();
if (instance_exists(obj_player)) control_state();

if (ground)
{
	velv = 0;
}
else
{
	velv += 0.2;
}

move_and_collide(velh, 0, tile);
move_and_collide(0, velv, tile);

counter_colorise();
adjust_sq();
swap_direction();