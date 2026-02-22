// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações


function start_drop()
{
    side = "up";
    start_y = y;
}

function drop(_px)
{
    switch (side)
    {
        case "up":
        {
            y -= 0.05;
            if (y <= (start_y - _px))
            {
                side = "down";
            }
        }
            break;
        case "down":
        {
            y += 0.05;
            if (y >= (start_y + _px))
            {
                side = "up";
            }
        }
            break;
    }
}