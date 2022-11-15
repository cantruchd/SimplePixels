import Toybox.Lang;
import Toybox.WatchUi;
import WatcherModule;
import Services;
import SensorInfoModule.SensorType;
import SettingsModule;

class AwakeWatcher extends WatcherModule.Watcher {
    public static var key as String = "AwakeWatcher";
    public var scope as Array<Scope> =
        [WatcherModule.ON_UPDATE, WatcherModule.ON_PARTIAL_UPDATE, WatcherModule.ON_NIGHT_MODE_CHANGED] as Array<Scope>;

    private var _isAwake as Boolean;
    private var _mainView as WatchUi.View;

    function initialize(mainView as WatchUi.View, isAwake as Boolean) {
        WatcherModule.Watcher.initialize();

        self._mainView = mainView;
        self._isAwake = isAwake;
    }

    function setIsAwake(isAwake as Boolean) as Void {
        self._isAwake = isAwake;
    }

    function get() as Lang.Object? {
        var service = Services.SensorInfo();
        var isNightMode = service.getValue(SensorType.IS_NIGHT_MODE_ENABLED);
        var isSleepTime = service.getValue(SensorType.IS_SLEEP_TIME);

        return isNightMode == true || isSleepTime == true ? false : self._isAwake;
    }

    private function updateViewProps(value as InstanceGetter) as Void {
        var isAwake = value as Boolean;
        var secondsViewID = $.VIEWS_LIST.get(:seconds);
        var secondsView = self._mainView.findDrawableById(secondsViewID) as SecondsView;
        var displaySecondsType = Services.WathersStore().getValue(DisplaySecondsWatcher) as DisplaySecondsType.Enum;

        secondsView.setViewProps(displaySecondsType, isAwake);
    }

    function onValueInit(value as InstanceGetter) as Void {
        self.updateViewProps(value);
    }

    function onValueUpdated(value as InstanceGetter, prevValue as InstanceGetter) as Void {
        self.updateViewProps(value);
    }
}
