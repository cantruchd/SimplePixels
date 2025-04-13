// this lists the views that can be drawn, thus when setting change these will be updated
import Toybox.Lang;

module ViewsKeys {
    enum Enum {
        BACKGROUND = "Background",
        // PREV_HOURS = "PrevHours",
        DATE = "Date",
        HOURS = "Hours",
        // NEXT_HOURS = "NextHours",        
        MINUTES = "Minutes",        
        // SECONDS = "Seconds",
        LEFT_SENSORS = "LeftSensors",
        LEFT_SENSORS2 = "LeftSensors2",
        RIGHT_SENSORS = "RightSensors"
    }

    const VALUES = [
        BACKGROUND,
        // PREV_HOURS,
        DATE,
        HOURS,
        // NEXT_HOURS,        
        MINUTES,        
        // SECONDS,
        LEFT_SENSORS,
        LEFT_SENSORS2,
        RIGHT_SENSORS
    ];
}
