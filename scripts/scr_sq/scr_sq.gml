// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


//use essa funcao quando quiser iniciar as variáveis do efeito (evento Create dentre outros que rodam 1 vez)
function start_sq(_valuex = 1, _valuey = 1)
{
	sq_xscale = _valuex;
	sq_yscale = _valuey;
}

//use essa funcao quando quiser que o player se estique (evento Step ou método Create)
function use_sq(_xscale = 1, _yscale = 1)
{
	sq_xscale = _xscale;
	sq_yscale = _yscale;
}

//use essa funcao para ajustar as propriedades do efeito pro normal (evento Step ou método Create)
function adjust_sq(_valuex = 1, _valuey = 1, _amount = .1)
{
	sq_xscale = lerp(sq_xscale, _valuex, _amount);
	sq_yscale = lerp(sq_yscale, _valuey, _amount);
}

//use essa funcao para desenhar corretamente a sprite em suas proporcoes (evento Draw)
function draw_sq()
{
	draw_sprite_ext(sprite_index, image_index, x, y, sq_xscale, sq_yscale, image_angle, c_white, image_alpha);
}

//use essa funcao se optar por algo mais simples, nao utiliza draw (alternativo, mas bom, evento Step ou método Create)
function simple_sq()
{
	image_xscale = sq_xscale;
	image_yscale = sq_yscale;
}
