import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.Time;
import ColorsModule;
import Services;
import SettingsModule;
import SettingsModule.SettingType;
import SettingsModule.DisplaySecondsType;
import SettingsMenuBuilder;
import SensorTypes;
import SensorsTexts;
import SensorsIcons;
import ResourcesCache;
import TimeStackModule;

class SettingsMenuBehavior extends WatchUi.Menu2InputDelegate {
    var _onBackCallback as Lang.Method;
    var _subMenuHandlers = {
        SettingType.BACKGROUND_COLOR => :colorHandler,
        SettingType.FOREGROUND_COLOR => :colorHandler,
        SettingType.INFO_COLOR => :colorHandler,
        SettingType.SEPARATOR_COLOR => :colorHandler,
        SettingType.SEPARATOR_INFO => :separatorFieldHandler,
        SettingType.RIGHT_SENSOR_1 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_2 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_3 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_4 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_5 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_6 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_7 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_8 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_9 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_10 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_11 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_12 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_13 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_14 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_15 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_16 => :sensorFieldHandler,

        SettingType.RIGHT_SENSOR_17 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_18 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_19 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_20 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_21 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_22 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_23 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_24 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_25 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_26 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_27 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_28 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_29 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_30 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_31 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_32 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_33 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_34 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_35 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_36 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_37 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_38 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_39 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_40 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_41 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_42 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_43 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_44 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_45 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_46 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_47 => :sensorFieldHandler,
        SettingType.RIGHT_SENSOR_48 => :sensorFieldHandler,

        SettingType.LEFT_SENSOR_1 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_2 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_3 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_4 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_5 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_6 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_7 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_8 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_9 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_10 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_11 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_12 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_13 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_14 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_15 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_16 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_17 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_18 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_19 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_20 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_21 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_22 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_23 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_24 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_25 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_26 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_27 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_28 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_29 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_30 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_31 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_32 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_33 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_34 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_35 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_36 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_37 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_38 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_39 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_40 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_41 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_42 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_43 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_44 => :sensorFieldHandler,
        SettingType.LEFT_SENSOR_45 => :sensorFieldHandler,


        // SettingType.LEFT_SENSOR_COLOR1 => :colorHandler,

        SettingType.LEFT_SENSOR => :sensorFieldHandler,
        SettingType.SHOW_STATUS_ICONS => :toggleFieldHandler,
        SettingType.DISPLAY_SECONDS => :displaySecondsHandler
    };

    function initialize(onBack as Lang.Method) {
        Menu2InputDelegate.initialize();
        Services.SensorInfo().init();
        ResourcesCache.clear();
        self._onBackCallback = onBack;
    }

    function _createCustomMenu(title as String) as WatchUi.Menu2 or WatchUi.CustomMenu {
        return new WatchUi.CustomMenu(35, Graphics.COLOR_WHITE, {
            :focusItemHeight => 45,
            :title => new DrawableMenuTitle(title),
            :footer => new DrawableMenuFooter()
        });
    }

    function _addColorItems(menu as WatchUi.CustomMenu or WatchUi.Menu2) as Void {
        var keys = ColorsModule.ColorsMap.keys() as Array<ColorsTypes.ColorTypeEnum>;

        for (var i = 0; i < keys.size(); i++) {
            var colorKey = keys[i];

            menu.addItem(
                SettingsMenuBuilder.BuildCustomColorMenuItem({
                    :identifier => colorKey as Number,
                    :color => ColorsModule.getColor(colorKey),
                    :label => ColorsModule.getColorName(colorKey)
                })
            );
        }
    }

    function _addSensorItems(
        menu as WatchUi.CustomMenu or WatchUi.Menu2,
        availableFields as Array<SensorTypes.SensorTypeEnum>?
    ) as Void {
        var sensorInfoService = Services.SensorInfo();
        var fields = availableFields != null ? availableFields : SensorsTexts.Map.keys() as Array<SensorTypes.SensorTypeEnum>;

        for (var i = 0; i < fields.size(); i++) {
            var sensorKey = fields[i];
            var text = SensorsTexts.getText(sensorKey);

            if (text == null || !sensorInfoService.isAvailable(sensorKey)) {
                continue;
            }

            menu.addItem(
                SettingsMenuBuilder.BuildCustomIconMenuItem({
                    :identifier => sensorKey as Number,
                    :label => text,
                    :icon => SensorsIcons.getIcon(sensorKey, true)
                })
            );
        }
    }

    function _addMapItems(menu as WatchUi.CustomMenu or WatchUi.Menu2, mapFields as Dictionary) as Void {
        var keys = mapFields.keys() as Array<Number>;

        for (var i = 0; i < keys.size(); i++) {
            var key = keys[i] as Number;

            menu.addItem(
                SettingsMenuBuilder.BuildCustomIconMenuItem({
                    :identifier => key,
                    :label => mapFields.get(key) as ResourceId
                })
            );
        }
    }

    function colorHandler(item as WatchUi.MenuItem or WatchUi.CustomMenuItem) as Void {
        var menu = self._createCustomMenu(item.getLabel());

        self.openMenu(item.getId() as SettingType.SettingTypeEnum, menu);
        self._addColorItems(menu);
        self.setFocusOnItem(item.getId() as SettingType.SettingTypeEnum, menu);
    }

    function sensorFieldHandler(item as WatchUi.MenuItem or WatchUi.CustomMenuItem) as Void {
        var menu = self._createCustomMenu(item.getLabel());

        self.openMenu(item.getId() as SettingType.SettingTypeEnum, menu);
        self._addSensorItems(menu, null);
        self.setFocusOnItem(item.getId() as SettingType.SettingTypeEnum, menu);
    }

    function separatorFieldHandler(item as WatchUi.MenuItem or WatchUi.CustomMenuItem) as Void {
        var menu = self._createCustomMenu(item.getLabel());

        self.openMenu(item.getId() as SettingType.SettingTypeEnum, menu);
        self._addSensorItems(menu, [
            SensorTypes.BATTERY,
            SensorTypes.ACTIVE_MINUTES_WEEK,
            SensorTypes.FLOORS,
            SensorTypes.STEPS
        ]);
        self.setFocusOnItem(item.getId() as SettingType.SettingTypeEnum, menu);
    }

    function displaySecondsHandler(item as WatchUi.ToggleMenuItem) as Void {
        var menu = self._createCustomMenu(item.getLabel());

        self.openMenu(item.getId() as SettingType.SettingTypeEnum, menu);
        self._addMapItems(menu, {
            DisplaySecondsType.NEVER => Rez.Strings.Never,
            DisplaySecondsType.ON_GESTURE => Rez.Strings.OnGesture
        });
        self.setFocusOnItem(item.getId() as SettingType.SettingTypeEnum, menu);
    }

    function toggleFieldHandler(item as WatchUi.ToggleMenuItem) as Void {
        SettingsModule.setValue(item.getId() as SettingType.SettingTypeEnum, item.isEnabled());
    }

    function setFocusOnItem(settingKey as SettingType.SettingTypeEnum, menu as WatchUi.Menu2 or WatchUi.CustomMenu) as Void {
        SettingsMenuBuilder.setFocusOnMenuItem(menu, settingKey);
    }

    function openMenu(settingKey as SettingType.SettingTypeEnum, menu as WatchUi.Menu2 or WatchUi.CustomMenu) as Void {
        WatchUi.switchToView(menu, new CustomMenuDelegate(settingKey, self._onBackCallback), WatchUi.SLIDE_IMMEDIATE);
    }

    function onSelect(item as WatchUi.MenuItem) as Void {
        ResourcesCache.clear();

        var handler = self._subMenuHandlers.get(item.getId() as SettingType.SettingTypeEnum);

        if (handler == null) {
            throw new Toybox.Lang.InvalidValueException("Handler is not registered");
        }

        var method = new Lang.Method(self, handler);

        method.invoke(item);
    }

    function onBack() as Void {
        self._onBackCallback.invoke();
        WatchUi.Menu2InputDelegate.onBack();
    }
}

class CustomMenuDelegate extends WatchUi.Menu2InputDelegate {
    var _settingKey as SettingType.SettingTypeEnum;
    var _onBackCallback as Method;

    function initialize(settingKey as SettingType.SettingTypeEnum, onBackCallback as Lang.Method) {
        Menu2InputDelegate.initialize();
        ResourcesCache.clear();

        self._settingKey = settingKey;
        self._onBackCallback = onBackCallback;
    }

    function onSelect(item) as Void {
        SettingsModule.setValue(self._settingKey, item.getId() as SettingType.SettingTypeEnum);
        self.onBack();
    }

    function onBack() as Void {
        RenderSettingsMenu(self._onBackCallback, WatchUi.SLIDE_DOWN, self._settingKey);
    }
}
