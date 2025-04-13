import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System; // Needed for System.println
import Toybox.Application; // Required for Properties

// Assuming these modules/namespaces exist and are correct
import Services;
import SettingsModule;
import SettingsModule.SettingType;
import SensorTypes;
import Components;
import ColorsModule; // Import base module
import ColorsModule.ColorsTypes; // Import nested types



class LeftSensorViewCopyFromRight extends Components.List {

    // --- Member Variables ---
    var _sensors as Array<SensorTypes.SensorTypeEnum> = [] as Array<SensorTypes.SensorTypeEnum>;
    var _fields as Array<SettingType.SettingTypeEnum> = [] as Array<SettingType.SettingTypeEnum>;
    // Holds the ENUM MEMBER (e.g., ColorsTypes.RED) corresponding to the setting for each field
    var _colorFields as Array<ColorsTypes.ColorTypeEnum> = [] as Array<ColorsTypes.ColorTypeEnum>;
    // Holds the final NUMERIC COLOR VALUE (e.g., 0xFF0000) for drawing each field
    var _sensorColors as Array<Graphics.ColorType?> = [] as Array<Graphics.ColorType?>;
    // Holds the general color for text (assuming defined elsewhere)
    // var _infoColor as Graphics.ColorType;
    // Cache for low power mode
    var lastItems as Array<Components.ItemType> = [] as Array<Components.ItemType>;

    // --- Initialization ---
    function initialize(params as SensorsInfoProps) {
        var fields = params.get(:fields);
        self._fields = fields != null ? fields : [];

        // Initial population of sensor types
        self._updateSensors();

        // Initial population of color enum keys and numeric colors
        self._populateColorData();

        // Call parent List initializer
        List.initialize(params);
    }

    // --- Settings Change Handler ---
    function onSettingsChanged() as Void {
        Components.List.onSettingsChanged(); // Call parent if needed

        // System.println("--- Running onSettingsChanged ---");

        // Update sensor types
        self._updateSensors();

        // Update color enum keys and numeric colors
        self._populateColorData(); // Re-populate color info    

        // Force redraw
        WatchUi.requestUpdate();
    }

    // --- Internal Data Update Functions ---

    // Populates _sensors array based on _fields settings
    function _updateSensors() as Void {        
        var sensors = new [self._fields.size()] as Array<SensorTypes.SensorTypeEnum>;
        for (var i = 0; i < self._fields.size(); i++) {
            var fieldType = self._fields[i];
            try {
                var sensor = SettingsModule.getValue(fieldType) as SensorTypes.SensorTypeEnum; // Assuming setting stores the SensorTypeEnum ID
                sensors[i] = sensor;
                //  System.println("  Sensor[" + i + "]: Read fieldType " + fieldType + ", got sensor " + sensor);
            } catch (ex instanceof Lang.Exception) {
                //  System.println("ERROR reading sensor setting for fieldType " + fieldType + ": " + ex.getErrorMessage());
                 sensors[i] = SensorTypes.NONE; // Default on error
            }
        }
        self._sensors = sensors;
        //  System.println("--- Finished _updateSensors ---");
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
                // System.println("  Populate[" + i + "]: WARNING - getColor returned non-Number for Enum "+ enumMember +". Using default WHITE.");
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

    // --- Rendering ---
    // Renders the list of sensor items
    protected function render(dc as Dc) as Void {
        var items = [] as Array<Components.ItemType>;

        // Check for low power mode / awake state using AwakeObserver
        if (AwakeObserver.isAwake && self.lastItems.size() > 0) {
            // If awake and cache exists, use cached items to reduce calculations
            items = self.lastItems;
            
        } else {
            // If not awake or cache is empty, generate new items
            
            for (var i = 0; i < self._sensors.size(); i++) {
                var sensorType = self._sensors[i];

                if (sensorType == SensorTypes.NONE || sensorType == null) {
                    // Add a placeholder or skip if sensor is NONE
                    items.add({
                        :text => null,
                        :icon => null,
                        :color => null // Or a default placeholder color
                    });
                } else {
                    // Generate item data using the helper function
                    items.add(self.getSensorItem(sensorType, i));
                }
            }
            // Update the cache with the newly generated items
            self.lastItems = items;
       }

        // Set the general draw color (using the overall info color)
        // Individual item colors should be handled by the renderItems method below
        // dc.setColor(self._infoColor, Graphics.COLOR_TRANSPARENT);

        // Call the parent component's renderItems function to draw the list
        self.renderItems({
            :items => items,
            :direction => Components.ListItemsDirection.RIGHT, // Or appropriate direction
            :drawContext => dc
        });
    }
}

