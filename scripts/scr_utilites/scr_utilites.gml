// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


global.fragmento = false;
global.destino = noone;
global.teleporting = false;
global.tp_destiny = noone;
global.transicao = false;
global.fragmento02 = false;

function goto_destiny()
{
    room_goto(global.destino);
}

function final_transicao()
{
	if (global.transicao) global.transicao = false;
}