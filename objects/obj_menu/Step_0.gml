/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


var _up = keyboard_check_pressed(vk_up);
var _down = keyboard_check_pressed(vk_down);
var _accept = keyboard_check_pressed(vk_enter);

if (_up && index > 0)
{
	index--;
	margem = 0;
}

if (_down && index < array_length(menu) - 1)
{
	index++;
	margem = 0;
}

margem = lerp(margem, 20, 0.1);

if (_accept)
{
	switch (index)
	{
		case 0:
		{
			room_goto(rm_intro);
		}
		break;
		
		case 1:
		{
			game_end();
		}
	}
}