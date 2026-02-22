//
// Simple passthrough fragment shader
//


//pelo amor de Deus e de todas as divindades que conseguir pensar ou crer nao faça alteracoes bruscas aqui
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    vec4 cor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	cor.rgb = vec3(1.0, 1.0, 1.0);
	
	
	gl_FragColor = cor;
}
