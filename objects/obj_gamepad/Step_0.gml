/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor


var _gamepads = gamepad_get_device_count();

for (var i = 0; i < _gamepads; i++)
{
    if (gamepad_is_connected(i))
    {
        global.gamepad_id = i;
    }
}

show_debug_message(global.gamepad_id);