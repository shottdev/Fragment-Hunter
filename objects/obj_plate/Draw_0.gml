/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

//me desenhando
draw_self();

//setando a fonte do texto
draw_set_font(fnt_tutorial);

//pegando o texto (de onde ele começa até onde ele vai)
var _texto = string_copy(texto, 0, index);

//pegando a altura da placa
var _spr_h = sprite_get_height(sprite_index);

//setando a escala x da caixa de diálogo
var _xscale = 2.4;

//pegando a largura da caixa de diálogo
var _spr_w = sprite_get_width(spr_dialogue) * _xscale;

//desenhando a caixa de diálogo baseando-se na sua largura e escala x
draw_sprite_ext(spr_dialogue, 0, x - _spr_w / 2, y - 50, _xscale, 1, 0, c_white, box_alpha);

//setando um eixo x para desenhar o texto
var _x = x - _spr_w / 2;


//desenhando o texto (aqui ele desenha o texto até um certo ponto, depois daí ele pula de linha, usa também a variavel _texto para pegar só o texto que já ta sendo mostrado pelo index)
draw_text_ext_transformed_colour(_x + margem, y - (50 - margem), _texto, 20, (_spr_w / 0.2) - margem, 0.2, 0.2, 0, c_white, c_white, c_white, c_white, box_alpha);

//resetando a fonte
draw_set_font(-1);