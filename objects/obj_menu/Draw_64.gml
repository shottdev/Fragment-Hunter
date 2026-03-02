/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

var _alt = 0;
for (var i = 0; i <= array_length(menu) - 1; i++)
{
	var _cor = c_white;
	var _marg = 0;
	
	if (index == i)
	{
		_cor = c_aqua;
		_marg = margem;
	}
	
	draw_set_colour(_cor);
	draw_set_font(fnt_menu);
	draw_text(20 + _marg, display_get_gui_height() / 2.7 + _alt, menu[i]);
	draw_set_font(-1);
	draw_set_colour(-1);
	
	_alt += 50;
}