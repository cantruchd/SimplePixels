import Toybox.Lang;
import Toybox.WatchUi;
import SettingsModule.SettingType;
import SettingsMenuBuilder;
import SensorsTexts;

function RenderSettingsMenu(onBack, transition as WatchUi.SlideType, selectedSetting as SettingType.SettingTypeEnum?) as Void {
    var menu = SettingsMenu();

    if (selectedSetting != null) {
        menu.setFocus(menu.findItemById(selectedSetting as Object));
    }

    WatchUi.switchToView(menu, new SettingsMenuBehavior(onBack as Method), transition);
}

function _getSubLabelValue(type as SettingType.SettingTypeEnum) as ResourceId {
    return SensorsTexts.getText(SettingsModule.getValue(type) as SensorTypes.SensorTypeEnum);
}

function SettingsMenu() as WatchUi.Menu2 or WatchUi.CustomMenu {
    var menu = new WatchUi.Menu2({ :title => Rez.Strings.SettingsMenu });
    
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR,
            :label => Rez.Strings.L,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR)
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildToggleMenuItem({
            :identifier => SettingType.SHOW_STATUS_ICONS,
            :label => Rez.Strings.DisplayStatusIcons,
            :options => {
                :alignment => WatchUi.MenuItem.MENU_ITEM_LABEL_ALIGN_RIGHT
            }
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_1,
            :label => Rez.Strings.R1,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_1)
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_2,
            :label => Rez.Strings.R2,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_2)
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_3,
            :label => Rez.Strings.R3,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_3)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_4,
            :label => Rez.Strings.R4,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_4)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_5,
            :label => Rez.Strings.R5,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_5)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_6,
            :label => Rez.Strings.R6,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_6)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_7,
            :label => Rez.Strings.R7,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_7)
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_8,
            :label => Rez.Strings.R8,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_8)
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_9,
            :label => Rez.Strings.R9,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_8)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_10,
            :label => Rez.Strings.R10,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_10)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_11,
            :label => Rez.Strings.R11,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_11)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_12,
            :label => Rez.Strings.R12,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_12)
        })
    );
    
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_13,
            :label => Rez.Strings.R13,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_13)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_14,
            :label => Rez.Strings.R14,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_14)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_15,
            :label => Rez.Strings.R15,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_15)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.RIGHT_SENSOR_16,
            :label => Rez.Strings.R16,
            :subLabel => _getSubLabelValue(SettingType.RIGHT_SENSOR_16)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_1,
            :label => Rez.Strings.L1,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_1)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_2,
            :label => Rez.Strings.L2,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_2)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_3,
            :label => Rez.Strings.L3,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_3)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_4,
            :label => Rez.Strings.L4,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_4)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_5,
            :label => Rez.Strings.L5,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_5)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_6,
            :label => Rez.Strings.L6,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_6)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_7,
            :label => Rez.Strings.L7,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_7)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_8,
            :label => Rez.Strings.L8,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_8)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_9,
            :label => Rez.Strings.L9,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_9)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_10,
            :label => Rez.Strings.L10,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_10)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_11,
            :label => Rez.Strings.L11,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_11)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_12,
            :label => Rez.Strings.L12,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_12)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_13,
            :label => Rez.Strings.L13,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_13)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_14,
            :label => Rez.Strings.L14,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_14)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.LEFT_SENSOR_15,
            :label => Rez.Strings.L15,
            :subLabel => _getSubLabelValue(SettingType.LEFT_SENSOR_15)
        })
    );

    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.BACKGROUND_COLOR,
            :label => Rez.Strings.BackgroundColorTitle
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.FOREGROUND_COLOR,
            :label => Rez.Strings.ForegroundColorTitle
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.INFO_COLOR,
            :label => Rez.Strings.InfoColorTitle
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.DISPLAY_SECONDS,
            :label => Rez.Strings.DisplaySeconds
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.SEPARATOR_COLOR,
            :label => Rez.Strings.SeparatorColorTitle
        })
    );
    menu.addItem(
        SettingsMenuBuilder.BuildMenuItem({
            :identifier => SettingType.SEPARATOR_INFO,
            :label => Rez.Strings.SeparatorInfoTitle,
            :subLabel => _getSubLabelValue(SettingType.SEPARATOR_INFO)
        })
    );

    
    return menu;
}
