/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


if (other.dash_duration == 0)
{
	if (!other.inv)
	{
		other.kb_duration = 5;
		other.damage_dir = (x - other.x);
		state = damage;
	}
	other.hurt();
}