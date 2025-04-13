import Toybox.Lang;
module ColorsModule {
    module ColorsTypes {
enum ColorTypeEnum {
    BLACK = 1,
    WHITE,
    GREEN,
    YELLOW,
    CYAN, 
    LIGHT_GREEN,
    LIGHT_PINK,
    BRIGHT_PINK,    
    RED,
    BLUE,
    PINK,
    LIGHT_YELLOW,
    LIGHT_BLUE
}


// Add this function (or similar logic)
        function getEnumFromId(id as Number) as ColorsTypes.ColorTypeEnum? {
            switch (id) {
                case 1: return ColorsTypes.BLACK;
                case 2: return ColorsTypes.WHITE;
                case 3: return ColorsTypes.GREEN;
                case 4: return ColorsTypes.YELLOW;
                case 5: return ColorsTypes.CYAN;
                case 6: return ColorsTypes.LIGHT_GREEN;
                case 7: return ColorsTypes.LIGHT_PINK;
                case 8: return ColorsTypes.BRIGHT_PINK;
                case 9: return ColorsTypes.RED;
                case 10: return ColorsTypes.BLUE;
                case 11: return ColorsTypes.PINK;
                case 12: return ColorsTypes.LIGHT_YELLOW;
                case 13: return ColorsTypes.LIGHT_BLUE;
                default: return null; // Handle invalid ID
            }
        }
    

}

    var ColorsMap = {
ColorsTypes.BLACK => 0x000000,
ColorsTypes.WHITE => 0xffffff,
ColorsTypes.GREEN => 0x00ff00,
ColorsTypes.YELLOW => 0xffff00,
ColorsTypes.CYAN => 0x55ffff,
ColorsTypes.LIGHT_GREEN => 0xaaff00,
ColorsTypes.LIGHT_PINK => 0xffb0ff,
ColorsTypes.BRIGHT_PINK => 0xfcd6fb,
ColorsTypes.RED => 0xff0000,
ColorsTypes.BLUE => 0x0000ff,
ColorsTypes.PINK => 0xE856F8,
ColorsTypes.LIGHT_YELLOW => 0xffffc6,
ColorsTypes.LIGHT_BLUE => Toybox.Graphics.COLOR_BLUE

    } as Dictionary<ColorsTypes.ColorTypeEnum, Number>;

    var TextsMap = {
ColorsTypes.BLACK => Rez.Strings.ColorBlack,
ColorsTypes.WHITE => Rez.Strings.ColorWhite,
ColorsTypes.GREEN => Rez.Strings.ColorGreen,
ColorsTypes.YELLOW => Rez.Strings.ColorYellow,
ColorsTypes.CYAN => Rez.Strings.ColorCyan,
ColorsTypes.LIGHT_GREEN => Rez.Strings.ColorLightGreen,
ColorsTypes.LIGHT_PINK => Rez.Strings.ColorLightPink,
ColorsTypes.BRIGHT_PINK => Rez.Strings.ColorBrightPink,
ColorsTypes.RED => Rez.Strings.ColorRed,
ColorsTypes.BLUE => Rez.Strings.ColorBlue,
ColorsTypes.PINK => Rez.Strings.ColorPink,
ColorsTypes.LIGHT_YELLOW => Rez.Strings.ColorLightYellow,
ColorsTypes.LIGHT_BLUE => Rez.Strings.ColorLightBlue


    } as Dictionary<ColorsTypes.ColorTypeEnum, ResourceId>;

    function getColor(key as ColorsTypes.ColorTypeEnum) as Number {
return ColorsMap.get(key) as Number;
    }

    function getColorName(key as ColorsTypes.ColorTypeEnum) as ResourceId {
return TextsMap.get(key) as ResourceId;
    }


}
