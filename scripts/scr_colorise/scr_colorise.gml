// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

/*
	
	Nota: nem tudo aqui é exatamente modificável só usando funcoes, caso seja necessária uma cor diferente, mexa no sh_cor
	por padrao a cor é branca.
	
	Feito por shott.dev

*/



//inicia a variavel do colorise
function start_colorise()
{
	c_timer = false;
}

//define um tempo pro timer do efeito em frames (Step ou método Create, quando quiser que o objeto fique colorido temporariamente)
function timer_colorise(_time = 5)
{
	c_timer = _time;
}

//faz o timer descer, e enquanto o timer for maior que 0 o objeto ficará da cor do shader (Step ou método Create, deve ser rodado sempre)
function counter_colorise()
{
	if (c_timer > 0) c_timer--;
}

//faz o objeto ficar da cor do shader se o timer nao for 0 (Draw)
function draw_colorise()
{
	if (c_timer)
	{
		shader_set(sh_colorise);
		draw_self();
		shader_set(-1);
	}
	else
	{
		draw_self();
	}
}



//(OPCIONAL) caso queira desenhar o efeito branco com outra funcao de efeito que é usada no Draw
function draw_colorise_func(_function)
{
	if (c_timer)
	{
		shader_set(sh_colorise);
		_function();
		shader_set(-1);
	}
	else
	{
		_function();
	}
}