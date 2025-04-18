import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import Services;
import SettingsModule;
import SettingsModule.SettingType;
import SensorTypes;
import Components;
import ColorsModule.ColorsTypes;

typedef SensorsInfoProps as Components.ListProps or
    {
    :fields as Array<SettingType.SettingTypeEnum>?
};

class RightSensorsView extends Components.List {
    var _sensors as Array<SensorTypes.SensorTypeEnum> = [] as Array<SensorTypes.SensorTypeEnum>;
    var _fields as Array<SettingType.SettingTypeEnum> = [] as Array<SettingType.SettingTypeEnum>;
    var _colorFields as Array<ColorsTypes.ColorTypeEnum> = [] as Array<ColorsTypes.ColorTypeEnum>;
    // Holds the final NUMERIC COLOR VALUE (e.g., 0xFF0000) for drawing each field
    var _sensorColors as Array<Graphics.ColorType?> = [] as Array<Graphics.ColorType?>;
    // Holds the general color for text (assuming defined elsewhere)
    // var _infoColor as Graphics.ColorType;
    // Cache for low power mode
    var lastItems as Array<Components.ItemType> = [] as Array<Components.ItemType>;

    function initialize(params as SensorsInfoProps) {
        var fields = params.get(:fields);
        self._fields = fields != null ? fields : [];
        self._updateSensors();
        self._populateColorData();

        List.initialize(params);
    }

    function _updateSensors() as Void {
        self._sensors = [] as Array<SensorTypes.SensorTypeEnum>;

        for (var i = 0; i < self._fields.size(); i++) {
            var fieldType = self._fields[i];

            self._sensors.add(SettingsModule.getValue(fieldType) as SensorTypes.SensorTypeEnum);
        }
    }

    function onSettingsChanged() as Void {
        Components.List.onSettingsChanged();

        self._updateSensors();
        self._populateColorData();
    }

    // Populates both _colorFields (Enum Keys) and _sensorColors (Numeric Values)
    // Combines the logic for getting keys and then getting colors
    private function _populateColorData() as Void {        
        var size = self._fields.size();
        var colorEnums = new [size] as Array<ColorsTypes.ColorTypeEnum>;
        var numericColors = new [size] as Array<Graphics.ColorType?>;

        for (var i = 0; i < size; i++) {
            var sensorFieldKey = self._fields[i];
            // Step 1: Get the ColorTypeEnum key for this sensor field
            var enumMember = self._getCorrespondingColorEnumKey(sensorFieldKey); // Renamed function for clarity
            colorEnums[i] = enumMember; // Store the enum key

            // Step 2: Use the enum key to get the numeric color value
            var colorValue = ColorsModule.getColor(enumMember); // Assumes ColorsModule.getColor is correct


            if (colorValue instanceof Number) {
                numericColors[i] = colorValue as Graphics.ColorType;
            } else {
                System.println("  Populate[" + i + "]: WARNING - getColor returned non-Number for Enum "+ enumMember +". Using default WHITE.");
                numericColors[i] = Graphics.COLOR_WHITE; // Default numeric color
            }
        }

        self._colorFields = colorEnums;
        self._sensorColors = numericColors;
    }


    // Renamed Function: Determines the ColorTypeEnum key associated with a Sensor Field setting key
    // This is where the conversion from the stored ID happens.
    private function _getCorrespondingColorEnumKey(sensorFieldKey as SettingType.SettingTypeEnum) as ColorsModule.ColorsTypes.ColorTypeEnum {
        
        var keyString = sensorFieldKey.toString();
        // System.println(keyString);
        var colorSettingKeyString = null; // Variable to hold the string like "LeftSensorColor1"

        // Determine the correct color setting key string based on the sensor field key
        if (keyString.length() >= 1 && keyString.substring(0, 1).equals("R")) {
            var index = keyString.substring("R".length(), keyString.length()).toNumber();
            colorSettingKeyString = "RC" + index;
        } else if (keyString.length() >= 1 && keyString.substring(0, 1).equals("L")) {
            var index = keyString.substring("L".length(), keyString.length()).toNumber();
            colorSettingKeyString = "LC" + index;
        }  
        
        
        var enumMember = ColorsModule.ColorsTypes.WHITE; // Default enum value if lookup fails

        if (colorSettingKeyString != null) {
            // Get the NUMERIC ID from settings
            var valueFromSettings = null;
             try {
                valueFromSettings = SettingsModule.getValue(colorSettingKeyString) as Number?;   
                // System.println("Color setting keystring: " + colorSettingKeyString + "value from settings" + valueFromSettings)             ;
             } catch (ex instanceof Lang.Exception) {
                 System.println("ERROR reading setting for '" + colorSettingKeyString + "': " + ex.getErrorMessage());
             }         

            if (valueFromSettings != null) {
                // CONVERT the numeric ID to the ENUM MEMBER using the helper
                // Make sure getEnumFromId exists in ColorsModule or ColorsModule.ColorsTypes
                // Adjust call scope if needed (e.g., ColorsModule.getEnumFromId if not in Types)
                var convertedEnum = ColorsModule.ColorsTypes.getEnumFromId(valueFromSettings);

              

                if (convertedEnum != null) {
                    enumMember = convertedEnum; // Assign if conversion successful
                } 
            } 
        }         
        return enumMember; // Return the actual enum member
    }


    // private function getSensorItem(sensorType as SensorTypes.SensorTypeEnum) as Components.ItemType {
    //     var sensorService = Services.SensorInfo();

    //     var icon = sensorService.getIcon(sensorType);

    //     if (sensorType == SensorTypes.BATTERY_IN_DAYS) {
    //         icon = sensorService.getIcon(SensorTypes.BATTERY);
    //     }

    //     return {
    //         :text => sensorService.transformValue(sensorType),
    //         :icon => icon
    //     };
    // }

    // --- Item Generation ---
    // Gets display data for a single sensor item
    private function getSensorItem(sensorType as SensorTypes.SensorTypeEnum, i as Number) as Components.ItemType {
        var sensorService = Services.SensorInfo(); // Assuming this service exists
        var icon = sensorService.getIcon(sensorType);
        var text = sensorService.transformValue(sensorType);

        // Handle special case for battery icon
        if (sensorType == SensorTypes.BATTERY_IN_DAYS) {
            icon = sensorService.getIcon(SensorTypes.BATTERY);
        }

        // Retrieve the pre-calculated numeric color value
        var color = Graphics.COLOR_WHITE; // Default color if something goes wrong
        if (i >= 0 && i < self._sensorColors.size()) { // Safety check
            var retrievedColor = self._sensorColors[i];
            if (retrievedColor != null) { // Check if null was stored
                 color = retrievedColor;
            } 
        }         

        return {
            :text => text,
            :icon => icon,
            :color => color // Pass the final numeric color
        };
    }
    
    

    protected function render(drawContext as Dc) as Void {
        var items = [] as Array<Components.ItemType>;

        if (AwakeObserver.isAwake &&  lastItems.size() > 0) {            
            items = lastItems;
        } else {
            for (var i = 0; i < self._sensors.size(); i++) {
                var sensorType = self._sensors[i] as SensorTypes.SensorTypeEnum;

                if (sensorType == SensorTypes.NONE) {
                    items.add({
                        :text => null,
                        :icon => null
                    });
                } else {
                    items.add(self.getSensorItem(sensorType, i));
                }
            }
            lastItems = items;
        }

        drawContext.setColor(self.infoColor, Graphics.COLOR_TRANSPARENT);

        self.renderItems({
            :items => items,
            :direction => Components.ListItemsDirection.LEFT,
            :drawContext => drawContext
        });
    }
}
