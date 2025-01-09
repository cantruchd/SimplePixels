import Toybox.Lang;
import ObserverModule;
import SettingsModule;

class DisplaySecondsObserver extends ObserverModule.ValueObserver {
    static var key as String = "DisplaySecondsObserver";
    var scope as Array<Scope> = [ObserverModule.ON_SETTINGS_CHANGED];

    function initialize(onValueUpdated as Method?) {
        ObserverModule.ValueObserver.initialize(onValueUpdated);
    }

    function getObservedValue() as Lang.Object? {
        return SettingsModule.getValue(SettingsModule.SettingType.DISPLAY_SECONDS);
    }
}
