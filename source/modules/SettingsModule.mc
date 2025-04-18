import Toybox.Lang;
import Toybox.Application.Properties;

(:background)
module SettingsModule {
    (:background)
    module SettingType {
        (:background)
        enum SettingTypeEnum {
            BACKGROUND_COLOR = "BackgroundColor",
            FOREGROUND_COLOR = "ForegroundColor",
            INFO_COLOR = "InfoColor",
            SEPARATOR_COLOR = "SeparatorC",
            SEPARATOR_INFO = "SeparatorInfo",

            RIGHT_SENSOR_1 = "R1",
            RIGHT_SENSOR_2 = "R2",
            RIGHT_SENSOR_3 = "R3",
            RIGHT_SENSOR_4 = "R4",
            RIGHT_SENSOR_5 = "R5",
            RIGHT_SENSOR_6 = "R6",
            RIGHT_SENSOR_7 = "R7",
            RIGHT_SENSOR_8 = "R8",
            RIGHT_SENSOR_9 = "R9",
            RIGHT_SENSOR_10 = "R10",
            RIGHT_SENSOR_11 = "R11",
            RIGHT_SENSOR_12 = "R12",
            RIGHT_SENSOR_13 = "R13",
            RIGHT_SENSOR_14 = "R14",
            RIGHT_SENSOR_15 = "R15",
            RIGHT_SENSOR_16 = "R16",
            RIGHT_SENSOR_17 = "R17",
            RIGHT_SENSOR_18 = "R18",
            RIGHT_SENSOR_19 = "R19",
            RIGHT_SENSOR_20 = "R20",
            RIGHT_SENSOR_21 = "R21",
            RIGHT_SENSOR_22 = "R22",
            RIGHT_SENSOR_23 = "R23",
            RIGHT_SENSOR_24 = "R24",
            RIGHT_SENSOR_25 = "R25",
            RIGHT_SENSOR_26 = "R26",
            RIGHT_SENSOR_27 = "R27",
            RIGHT_SENSOR_28 = "R28",
            RIGHT_SENSOR_29 = "R29",
            RIGHT_SENSOR_30 = "R30",
            RIGHT_SENSOR_31 = "R31",
            RIGHT_SENSOR_32 = "R32",
            RIGHT_SENSOR_33 = "R33",
            RIGHT_SENSOR_34 = "R34",
            RIGHT_SENSOR_35 = "R35",
            RIGHT_SENSOR_36 = "R36",
            RIGHT_SENSOR_37 = "R37",
            RIGHT_SENSOR_38 = "R38",
            RIGHT_SENSOR_39 = "R39",
            RIGHT_SENSOR_40 = "R40",
            RIGHT_SENSOR_41 = "R41",
            RIGHT_SENSOR_42 = "R42",
            RIGHT_SENSOR_43 = "R43",
            RIGHT_SENSOR_44 = "R44",
            RIGHT_SENSOR_45 = "R45",
            RIGHT_SENSOR_46 = "R46",
            RIGHT_SENSOR_47 = "R47",
            RIGHT_SENSOR_48 = "R48",

            RIGHT_SENSOR_COLOR1 = "RC1",
            RIGHT_SENSOR_COLOR2 = "RC2",
            RIGHT_SENSOR_COLOR3 = "RC3",
            RIGHT_SENSOR_COLOR4 = "RC4",
            RIGHT_SENSOR_COLOR5 = "RC5",
            RIGHT_SENSOR_COLOR6 = "RC6",
            RIGHT_SENSOR_COLOR7 = "RC7",
            RIGHT_SENSOR_COLOR8 = "RC8",
            RIGHT_SENSOR_COLOR9 = "RC9",
            RIGHT_SENSOR_COLOR10 = "RC10",
            RIGHT_SENSOR_COLOR11 = "RC11",
            RIGHT_SENSOR_COLOR12 = "RC12",
            RIGHT_SENSOR_COLOR13 = "RC13",
            RIGHT_SENSOR_COLOR14 = "RC14",
            RIGHT_SENSOR_COLOR15 = "RC15",
            RIGHT_SENSOR_COLOR16 = "RC16",
            RIGHT_SENSOR_COLOR17 = "RC17",
            RIGHT_SENSOR_COLOR18 = "RC18",
            RIGHT_SENSOR_COLOR19 = "RC19",
            RIGHT_SENSOR_COLOR20 = "RC20",
            RIGHT_SENSOR_COLOR21 = "RC21",
            RIGHT_SENSOR_COLOR22 = "RC22",
            RIGHT_SENSOR_COLOR23 = "RC23",
            RIGHT_SENSOR_COLOR24 = "RC24",
            RIGHT_SENSOR_COLOR25 = "RC25",
            RIGHT_SENSOR_COLOR26 = "RC26",
            RIGHT_SENSOR_COLOR27 = "RC27",
            RIGHT_SENSOR_COLOR28 = "RC28",
            RIGHT_SENSOR_COLOR29 = "RC29",
            RIGHT_SENSOR_COLOR30 = "RC30",
            RIGHT_SENSOR_COLOR31 = "RC31",
            RIGHT_SENSOR_COLOR32 = "RC32",
            RIGHT_SENSOR_COLOR33 = "RC33",
            RIGHT_SENSOR_COLOR34 = "RC34",
            RIGHT_SENSOR_COLOR35 = "RC35",
            RIGHT_SENSOR_COLOR36 = "RC36",
            RIGHT_SENSOR_COLOR37 = "RC37",
            RIGHT_SENSOR_COLOR38 = "RC38",
            RIGHT_SENSOR_COLOR39 = "RC39",
            RIGHT_SENSOR_COLOR40 = "RC40",
            RIGHT_SENSOR_COLOR41 = "RC41",
            RIGHT_SENSOR_COLOR42 = "RC42",
            RIGHT_SENSOR_COLOR43 = "RC43",
            RIGHT_SENSOR_COLOR44 = "RC44",
            RIGHT_SENSOR_COLOR45 = "RC45",
            RIGHT_SENSOR_COLOR46 = "RC46",
            RIGHT_SENSOR_COLOR47 = "RC47",
            RIGHT_SENSOR_COLOR48 = "RC48",

            LEFT_SENSOR_1 = "L1",
            LEFT_SENSOR_2 = "L2",
            LEFT_SENSOR_3 = "L3",
            LEFT_SENSOR_4 = "L4",
            LEFT_SENSOR_5 = "L5",
            LEFT_SENSOR_6 = "L6",
            LEFT_SENSOR_7 = "L7",
            LEFT_SENSOR_8 = "L8",
            LEFT_SENSOR_9 = "L9",
            LEFT_SENSOR_10 = "L10",
            LEFT_SENSOR_11 = "L11",
            LEFT_SENSOR_12 = "L12",
            LEFT_SENSOR_13 = "L13",
            LEFT_SENSOR_14 = "L14",
            LEFT_SENSOR_15 = "L15",
            LEFT_SENSOR_16 = "L16",
            LEFT_SENSOR_17 = "L17",
            LEFT_SENSOR_18 = "L18",
            LEFT_SENSOR_19 = "L19",
            LEFT_SENSOR_20 = "L20",
            LEFT_SENSOR_21 = "L21",
            LEFT_SENSOR_22 = "L22",
            LEFT_SENSOR_23 = "L23",
            LEFT_SENSOR_24 = "L24",
            LEFT_SENSOR_25 = "L25",
            LEFT_SENSOR_26 = "L26",
            LEFT_SENSOR_27 = "L27",
            LEFT_SENSOR_28 = "L28",
            LEFT_SENSOR_29 = "L29",
            LEFT_SENSOR_30 = "L30",
            LEFT_SENSOR_31 = "L31",
            LEFT_SENSOR_32 = "L32",
            LEFT_SENSOR_33 = "L33",
            LEFT_SENSOR_34 = "L34",
            LEFT_SENSOR_35 = "L35",
            LEFT_SENSOR_36 = "L36",
            LEFT_SENSOR_37 = "L37",
            LEFT_SENSOR_38 = "L38",
            LEFT_SENSOR_39 = "L39",
            LEFT_SENSOR_40 = "L40",
            LEFT_SENSOR_41 = "L41",
            LEFT_SENSOR_42 = "L42",
            LEFT_SENSOR_43 = "L43",
            LEFT_SENSOR_44 = "L44",
            LEFT_SENSOR_45 = "L45",

            LEFT_SENSOR_COLOR1 = "LC1",
            LEFT_SENSOR_COLOR2 = "LC2",
            LEFT_SENSOR_COLOR3 = "LC3",
            LEFT_SENSOR_COLOR4 = "LC4",
            LEFT_SENSOR_COLOR5 = "LC5",
            LEFT_SENSOR_COLOR6 = "LC6",
            LEFT_SENSOR_COLOR7 = "LC7",
            LEFT_SENSOR_COLOR8 = "LC8",
            LEFT_SENSOR_COLOR9 = "LC9",
            LEFT_SENSOR_COLOR10 = "LC10",
            LEFT_SENSOR_COLOR11 = "LC11",
            LEFT_SENSOR_COLOR12 = "LC12",
            LEFT_SENSOR_COLOR13 = "LC13",
            LEFT_SENSOR_COLOR14 = "LC14",
            LEFT_SENSOR_COLOR15 = "LC15",
            LEFT_SENSOR_COLOR16 = "LC16",
            LEFT_SENSOR_COLOR17 = "LC17",
            LEFT_SENSOR_COLOR18 = "LC18",
            LEFT_SENSOR_COLOR19 = "LC19",
            LEFT_SENSOR_COLOR20 = "LC20",
            LEFT_SENSOR_COLOR21 = "LC21",
            LEFT_SENSOR_COLOR22 = "LC22",
            LEFT_SENSOR_COLOR23 = "LC23",
            LEFT_SENSOR_COLOR24 = "LC24",
            LEFT_SENSOR_COLOR25 = "LC25",
            LEFT_SENSOR_COLOR26 = "LC26",
            LEFT_SENSOR_COLOR27 = "LC27",
            LEFT_SENSOR_COLOR28 = "LC28",
            LEFT_SENSOR_COLOR29 = "LC29",
            LEFT_SENSOR_COLOR30 = "LC30",
            LEFT_SENSOR_COLOR31 = "LC31",
            LEFT_SENSOR_COLOR32 = "LC32",
            LEFT_SENSOR_COLOR33 = "LC33",
            LEFT_SENSOR_COLOR34 = "LC34",
            LEFT_SENSOR_COLOR35 = "LC35",
            LEFT_SENSOR_COLOR36 = "LC36",
            LEFT_SENSOR_COLOR37 = "LC37",
            LEFT_SENSOR_COLOR38 = "LC38",
            LEFT_SENSOR_COLOR39 = "LC39",
            LEFT_SENSOR_COLOR40 = "LC40",
            LEFT_SENSOR_COLOR41 = "LC41",
            LEFT_SENSOR_COLOR42 = "LC42",
            LEFT_SENSOR_COLOR43 = "LC43",
            LEFT_SENSOR_COLOR44 = "LC44",
            LEFT_SENSOR_COLOR45 = "LC45",

            NUM_COL_LEFT = "NumColLeft",
            NUM_COL_RIGHT = "NumColRight",

            LEFT_SENSOR = "L",
            SHOW_STATUS_ICONS = "DisplayStatusIcons", // to migrate
            DISPLAY_SECONDS = "DisplaySeconds",
            SECOND_TIME_FORMAT = "SecondTimeFormat",
            OW_API_KEY = "OpenWeatherAPIKey",
            OW_INTERVAL = "OpenWeatherIntervalMinutes",
            OW_ENABLED = "OpenWeatherEnabled",
            OW_LAT = "OpenWeatherLat",
            OW_LON = "OpenWeatherLon",
            DOT_HOUR_TRANS = "DotHourTransparency",
            DATE_FORMAT = "DateFormat"
        }
    }

    module DisplaySecondsType {
        enum Enum {
            NEVER = 0,
            ON_GESTURE = 1
        }
    }

    function setValue(settingKey as SettingType.SettingTypeEnum, value as String or Boolean or Number) as Void {
        Toybox.System.println(settingKey + ": " + value);
        Properties.setValue(settingKey as String, value);
    }

    (:background)
    function getValue(settingKey as SettingType.SettingTypeEnum or String) as String or Number or Boolean or Dictionary or Null {
        try {
            // Toybox.System.println(settingKey);
            return Properties.getValue(settingKey as String);
        } catch (e) {
            Toybox.System.println("Exception: " + settingKey);
            return null;
        }
    }
}
