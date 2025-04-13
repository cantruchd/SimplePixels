import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import GlobalKeys;
import SettingsModule;
import SettingsModule.SettingType;

module Components {
    module ListItemsDirection {
        enum Enum {
            LEFT = 1,
            RIGHT
        }
    }

    typedef ItemType as {
        :text as String?,
        :icon as FontResource?,
        :icons as Array<FontResource>?,
        :color as Number?
    };

    typedef ItemsRenderProps as {
        :items as Array<ItemType>,
        :drawContext as Dc,
        :derection as ListItemsDirection.Enum?
    };

    typedef ElementRenderProps as {
        :item as ItemType,
        :derection as ListItemsDirection.Enum?,
        :posX as Numeric,
        :posY as Numeric
    };

    typedef ListProps as BoxProps or
        {
        :itemHeight as String?,
        :iconSize as String?
    };

    class List extends Box {
        protected var _itemHeight as Numeric;
        protected var _iconSize as Numeric;

        function initialize(params as ListProps) {
            Box.initialize(params);

            var itemHeight = params.get(:itemHeight);
            self._itemHeight = itemHeight != null ? self.parseActualSize(itemHeight, GlobalKeys.SCREEN_HEIGHT) : 10;

            var iconSize = params.get(:iconSize);
            self._iconSize = iconSize != null ? self.parseActualSize(iconSize, GlobalKeys.SCREEN_HEIGHT) : 10;
        }

        private function setupItemHeight(drawContext as Dc) as Void {
            if (self._itemHeight != null) {
                return;
            }

            self._itemHeight = drawContext.getFontHeight(self.getFont());
        }

        private function getJustify(direction as ListItemsDirection.Enum) {
            if (direction == ListItemsDirection.LEFT) {
                return Graphics.TEXT_JUSTIFY_LEFT;
            }

            return Graphics.TEXT_JUSTIFY_RIGHT;
        }

        private function renderText(props as ElementRenderProps, drawContext as Dc) as Void {            
            var item = props.get(:item);
            var text = item.get(:text);
            var color = item.get(:color);

            if (text == null || text == "") {
                return;
            }

            var posX = props.get(:posX);
            var textYPos = props.get(:posY);
            var textDerection = props.get(:direction);

            var textXPos = posX + self._iconSize;
            var textJustify = self.getJustify(textDerection);

            if (textDerection == ListItemsDirection.RIGHT) {
                textXPos = posX - self._iconSize;
            }
            if (color!= null)
            {
                // Toybox.System.println("Set color: "+ color);
                drawContext.setColor(color, Graphics.COLOR_TRANSPARENT);
            }
            

            drawContext.drawText(textXPos, textYPos, self.getFont(), text, textJustify);
        }

        private function renderIcon(props as ElementRenderProps, drawContext as Dc) as Void {            
            var item = props.get(:item);
            var icon = item.get(:icon);

            if (icon == null) {
                return;
            }

            var posX = props.get(:posX);
            var posY = props.get(:posY);

            var iconDerection = props.get(:direction);
            var iconJustify = self.getJustify(iconDerection);

            drawContext.drawText(posX, posY, icon, GlobalKeys.ICON_SYMBOL, iconJustify);
            
            
        }

        private function renderIcons(props as ElementRenderProps, drawContext as Dc) as Void {       
                   

            var item = props.get(:item) as ItemType;
            var icons = item.get(:icons) as Array<FontResource>?;

            

            if (icons == null || icons.size() == 0) {
                // System.println("returning");
                return;
            }

            // return;
            
            //override position here
            var posX = 141;
            var posY = 1;
            // var posX = props.get(:posX);
            // var posY = props.get(:posY);

            var iconDerection = props.get(:direction);
            var iconJustify = self.getJustify(iconDerection);

            for (var i = 0; i < icons.size(); i++) {
                var icon = icons[i];
                var offset = i * self._iconSize;
                var iconXPos = posX;

                if (offset > 0) {
                    switch (iconJustify) {
                        case Graphics.TEXT_JUSTIFY_LEFT:
                            iconXPos += offset;
                            break;

                        case Graphics.TEXT_JUSTIFY_RIGHT:
                            iconXPos -= offset;
                            break;
                    }
                }             
                
                drawContext.drawText(iconXPos, posY, icon, GlobalKeys.ICON_SYMBOL, iconJustify);
                // System.println("x:"+ posX + "y: "+ posY);                
                
            }
            
            // System.println(icons.size());
            // drawContext.setColor(Graphics.COLOR_YELLOW, Graphics.COLOR_TRANSPARENT);  
            // drawContext.drawText(182, 133, Graphics.FONT_SYSTEM_SMALL, "AAAAAAAAAAAAAAAAAA", Graphics.TEXT_JUSTIFY_LEFT);
            
        }

        // function stringReplace(str, oldString, newString) {
        //     var result = str;

        //     while (true) {
        //         var index = result.find(oldString);
        //         System.println(index);
        //         if (index != null) {
        //             var index2 = index + oldString.length();
        //             result = result.substring(0, index) + newString + result.substring(index2, result.length());
        //         } else {
        //             return result;
        //         }
        //     }

        //     return null;
        // }

        protected function renderItems(props as ItemsRenderProps) as Void {
            var drawContext = props.get(:drawContext);
            var items = props.get(:items);
            var direction = props.get(:direction);
            var posX = self.getPosX();
            var posY = self.getPosY();
            var currentPosX = posX;

            direction = direction != null ? direction : ListItemsDirection.LEFT;

            if (direction == ListItemsDirection.RIGHT) {
                posX = posX + self.getWidth();
            }

            var count = 0;
            var numCol = 1;
            if (direction == ListItemsDirection.RIGHT)
            {
                numCol = SettingsModule.getValue(SettingType.NUM_COL_LEFT) as Number;
            }
            else
            {
                numCol = SettingsModule.getValue(SettingType.NUM_COL_RIGHT) as Number;
            }
            
            currentPosX = posX;
            for (var i = 0; i < items.size(); i++) {
                // System.println("Post x:" + currentPosX);
                // System.println("Post y:" + posY);
                var item = items[i];                
                if (count == numCol) {                    
                    posY = posY + self._itemHeight;
                    count = 0;
                    currentPosX = posX;                    
                }
                count = count + 1;
                // var itemYPos = i > 0 ? posY + self._itemHeight * i : posY;

                var renderProps = {
                    :item => item,
                    :direction => direction,
                    :posX => currentPosX,
                    :posY => posY
                };

                self.renderText(renderProps, drawContext);
                self.renderIcon(renderProps, drawContext);
                self.renderIcons(renderProps, drawContext);
                if (item != null) {
                    // var textLength = (item.get(:text) as String).length();
                    var text = item.get(:text) as String;
                    var shift = 0;

                    if (text != null) {
                        var len = text.length();
                        for (var index = 0; index < len; index++) {
                            var char = text.substring(index, index+1);
                            
                            // System.println(char);
                            // System.println(char.equals("."));        
                            switch (char)                    
                            {
                                case ".":
                                case "1":
                                case ":":  
                                case "/":
                                    shift = 5;
                                    break;                                
                                case " ":
                                case "-":
                                    shift = 6;
                                    break;
                                case "0":
                                case "2":
                                case "3":
                                case "4":
                                case "5":
                                case "6":
                                case "7":
                                case "8":
                                case "9":
                                case "2":
                                    shift = 10;
                                    break;
                                case "m":                                
                                    shift = 14;
                                    break;
                                case "%":
                                    shift = 16;
                                    break;
                                default: //  a to z
                                    shift = 11;
                                    break;
                            }                            

                            if (direction == ListItemsDirection.RIGHT)
                            {
                                shift = -shift;
                            }
                            currentPosX = currentPosX + shift;
                            // if (len==1)
                            // {
                            //     currentPosX = currentPosX + shift; 
                            // }
                        }
                        //  System.println("New posx:" + currentPosX);
                         if (direction == ListItemsDirection.RIGHT)
                            {
                                currentPosX = currentPosX - 19; // to accomodate icon width;    
                            }
                        else
                        {   
                            currentPosX = currentPosX + 19; // to accomodate icon width;
                        }
                         
                        
                    }
                }
            }
        }

        protected function onRenderBefore(drawContext as Dc) {
            Box.onRenderBefore(drawContext);
            self.setupItemHeight(drawContext);
        }
    }
}



// import Toybox.Lang;
// import Toybox.WatchUi;
// import Toybox.Graphics;
// import GlobalKeys;
// import SettingsModule;
// import SettingsModule.SettingType;

// module Components {
//     module ListItemsDirection {
//         enum Enum {
//             LEFT = 1,
//             RIGHT
//         }
//     }

//     typedef ItemType as {
//         :text as String?,
//         :icon as FontResource?,
//         :icons as Array<FontResource>?,
//         :color as Graphics.ColorType or Null
//     };

//     typedef ItemsRenderProps as {
//         :items as Array<ItemType>,
//         :drawContext as Dc,
//         :derection as ListItemsDirection.Enum?
//     };

//     typedef ElementRenderProps as {
//         :item as ItemType,
//         :derection as ListItemsDirection.Enum?,
//         :posX as Numeric,
//         :posY as Numeric
//     };

//     typedef ListProps as BoxProps or
//         {
//         :itemHeight as String?,
//         :iconSize as String?
//     };

//     class List extends Box {
//         protected var _itemHeight as Numeric;
//         protected var _iconSize as Numeric;

//         function initialize(params as ListProps) {
//             Box.initialize(params);

//             var itemHeight = params.get(:itemHeight);
//             self._itemHeight = itemHeight != null ? self.parseActualSize(itemHeight, GlobalKeys.SCREEN_HEIGHT) : 10;

//             var iconSize = params.get(:iconSize);
//             self._iconSize = iconSize != null ? self.parseActualSize(iconSize, GlobalKeys.SCREEN_HEIGHT) : 10;
//         }

//         private function setupItemHeight(drawContext as Dc) as Void {
//             if (self._itemHeight != null) {
//                 return;
//             }

//             self._itemHeight = drawContext.getFontHeight(self.getFont());
//         }

//         private function getJustify(direction as ListItemsDirection.Enum) {
//             if (direction == ListItemsDirection.LEFT) {
//                 return Graphics.TEXT_JUSTIFY_LEFT;
//             }

//             return Graphics.TEXT_JUSTIFY_RIGHT;
//         }

//         private function renderText(props as ElementRenderProps, drawContext as Dc) as Void {
//             var item = props.get(:item);
//             var text = item.get(:text);
//             var itemColor = item.get(:color);

//             if (text == null || text == "") {
//                 return;
//             }

//             var posX = props.get(:posX);
//             var textYPos = props.get(:posY);
//             var textDerection = props.get(:direction);

//             var textXPos = posX + self._iconSize;
//             var textJustify = self.getJustify(textDerection);

//             if (textDerection == ListItemsDirection.RIGHT) {
//                 textXPos = posX - self._iconSize;
//             }

//             if (itemColor != null) {
//                 drawContext.setColor(itemColor, Graphics.COLOR_TRANSPARENT);
//             }

//             drawContext.drawText(textXPos, textYPos, self.getFont(), text, textJustify);
//         }

//         private function renderIcon(props as ElementRenderProps, drawContext as Dc) as Void {
//             var item = props.get(:item);
//             var icon = item.get(:icon);
//             var itemColor = item.get(:color);

//             if (icon == null) {
//                 return;
//             }

//             var posX = props.get(:posX);
//             var posY = props.get(:posY);

//             var iconDerection = props.get(:direction);
//             var iconJustify = self.getJustify(iconDerection);

//             if (itemColor != null) {
//                 drawContext.setColor(itemColor, Graphics.COLOR_TRANSPARENT);
//             }

//             drawContext.drawText(posX, posY, icon, GlobalKeys.ICON_SYMBOL, iconJustify);
//         }

//         private function renderIcons(props as ElementRenderProps, drawContext as Dc) as Void {
//             var item = props.get(:item) as ItemType;
//             var icons = item.get(:icons) as Array<FontResource>?;
//             var itemColor = item.get(:color);

//             if (icons == null || icons.size() == 0) {
//                 return;
//             }

//             var posX = props.get(:posX);
//             var posY = props.get(:posY);

//             var iconDerection = props.get(:direction);
//             var iconJustify = self.getJustify(iconDerection);

//             if (itemColor != null) {
//                 drawContext.setColor(itemColor, Graphics.COLOR_TRANSPARENT);
//             }

//             for (var i = 0; i < icons.size(); i++) {
//                 var icon = icons[i];
//                 var offset = i * self._iconSize;
//                 var iconXPos = posX;

//                 if (offset > 0) {
//                     switch (iconJustify) {
//                         case Graphics.TEXT_JUSTIFY_LEFT:
//                             iconXPos += offset;
//                             break;

//                         case Graphics.TEXT_JUSTIFY_RIGHT:
//                             iconXPos -= offset;
//                             break;
//                     }
//                 }

//                 drawContext.drawText(iconXPos, posY, icon, GlobalKeys.ICON_SYMBOL, iconJustify);
//             }
//         }

//         protected function renderItems(props as ItemsRenderProps) as Void {
//             var drawContext = props.get(:drawContext);
//             var items = props.get(:items);
//             var direction = props.get(:direction);
//             var posX = self.getPosX();
//             var posY = self.getPosY();
//             var currentPosX = posX;

//             direction = direction != null ? direction : ListItemsDirection.LEFT;

//             if (direction == ListItemsDirection.RIGHT) {
//                 posX = posX + self.getWidth();
//             }

//             var count = 0;
//             var numCol = 1;
//             if (direction == ListItemsDirection.RIGHT)
//             {
//                 numCol = SettingsModule.getValue(SettingType.NUM_COL_LEFT) as Number;
//             }
//             else
//             {
//                 numCol = SettingsModule.getValue(SettingType.NUM_COL_RIGHT) as Number;
//             }


//             for (var i = 0; i < items.size(); i++) {
//                 var item = items[i];
//                 count = count + 1;
//                 if (count == numCol) {
//                     posY = posY + self._itemHeight;
//                     count = 0;
//                     currentPosX = posX;
//                 }

//                 var renderProps = {
//                     :item => item,
//                     :direction => direction,
//                     :posX => currentPosX,
//                     :posY => posY
//                 };

//                 self.renderText(renderProps, drawContext);
//                 self.renderIcon(renderProps, drawContext);
//                 self.renderIcons(renderProps, drawContext);
//                 if (item != null) {
//                     var text = item.get(:text) as String;

//                     if (text != null) {
//                         var len = text.length();
//                         for (var index = 0; index < len; index++) {
//                             var char = text.substring(index, index+1);
//                             var shift = 0;
//                             if (char.equals(".") || char.equals("1"))
//                             {
//                                 shift = 3;
//                             }
//                             else
//                             {
//                                 shift = 15;
//                             }

//                             if (direction == ListItemsDirection.RIGHT)
//                             {
//                                 shift = -shift;
//                             }
//                             currentPosX = currentPosX + shift;
//                             if (len==1)
//                             {
//                                 currentPosX = currentPosX + shift;
//                             }
//                         }
//                     }
//                 }
//             }
//         }

//         protected function onRenderBefore(drawContext as Dc) {
//             Box.onRenderBefore(drawContext);
//             self.setupItemHeight(drawContext);
//         }
//     }
// }