import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import SettingsModule;

module SettingsMenuBuilder {
    typedef MenuProps as { :title as Symbol, :focus as Number? };

    typedef CustomMenuProps as {
        :itemHeight as Number,
        :backgroundColor as Graphics.ColorType,
        :options as
            {
                :focus as Number?,
                :focusItemHeight as Number?,
                :title as WatchUi.Drawable?,
                :footer as WatchUi.Drawable?,
                :foreground as WatchUi.Drawable?,
                :titleItemHeight as Number?,
                :footerItemHeight as Number?
            }?
    };

    typedef MenuItemProps as {
        :label as Symbol,
        :subLabel as Symbol?,
        :identifier as Object or Number or String,
        :options as { :alignment as MenuItem.Alignment }?
    };

    typedef ToggleItemProps as {
        :label as Symbol,
        :subLabel as Symbol?,
        :identifier as Object or Number or String,
        :enabled as Boolean?,
        :options as { :alignment as MenuItem.Alignment }?
    };

    typedef MenuValueKey as SettingType.Enum;

    typedef GenerateItemProps as {
        :buider as ItemBuilder,
        :buiderProps as MenuItemProps or CustomColorMenuItemProps or CustomIconMenuItemProps or ToggleItemProps,
        :valueKey as MenuValueKey?
    };

    typedef GenerateMenuProps as {
        :buider as MenuBuilder,
        :buiderProps as MenuProps or CustomMenuProps,
        :valueKey as MenuValueKey?,
    };

    function generateMenuItem(props as GenerateItemProps) as WatchUi.MenuItem or WatchUi.CustomMenuItem {
        var itemBuilder = props.get(:buider);

        if (itemBuilder == null) {
            throw new Toybox.Lang.InvalidValueException("the item buider prop is required");
        }

        itemBuilder = itemBuidersMap.get(itemBuilder);

        if (itemBuilder == null) {
            throw new Toybox.Lang.InvalidValueException("the item buider prop has an incorrect value");
        }

        var method = new Lang.Method(SettingsMenuBuilder, itemBuilder);

        return method.invoke(props.get(:buiderProps), props.get(:valueKey));
    }

    function generateMenu(props as GenerateMenuProps, items as Array<GenerateItemProps>) as WatchUi.Menu2 or WatchUi.CustomMenu {
        var menuBuilder = props.get(:buider);

        if (menuBuilder == null) {
            throw new Toybox.Lang.InvalidValueException("the menu buider prop is required");
        }

        menuBuilder = menuBuidersMap.get(menuBuilder);

        if (menuBuilder == null) {
            throw new Toybox.Lang.InvalidValueException("the menu buider prop has an incorrect value");
        }

        var valueKey = props.get(:valueKey);
        var method = new Lang.Method(SettingsMenuBuilder, menuBuilder);
        var menu = method.invoke(props.get(:buiderProps));

        $.clearDictionary(props);

        while (items.size() > 0) {
            menu.addItem(generateMenuItem(items[0]));
            items.remove(items[0]);
        }

        if (valueKey != null) {
            var settingValue = SettingsModule.getValue(valueKey);
            var valueItem = menu.findItemById(settingValue);

            menu.setFocus(valueItem);
        }

        return menu;
    }

    enum MenuBuilder {
        MENU = 1,
        CUSTOM_MENU
    }

    var menuBuidersMap = {
        MENU => :BuildMenu,
        CUSTOM_MENU => :BuildCustomMenu
    };

    function BuildMenu(params as MenuProps) as WatchUi.Menu2 {
        return new WatchUi.Menu2(params);
    }

    function BuildCustomMenu(params as CustomMenuProps) as WatchUi.CustomMenu {
        return new WatchUi.CustomMenu(params.get(:itemHeight), params.get(:backgroundColor), params.get(:options));
    }

    enum ItemBuilder {
        ITEM = 1,
        CUSTOM_COLOR_ITEM,
        CUSTOM_ICON_ITEM,
        TOGGLE_ITEM
    }

    var itemBuidersMap = {
        ITEM => :BuildMenuItem,
        CUSTOM_COLOR_ITEM => :BuildCustomColorMenuItem,
        CUSTOM_ICON_ITEM => :BuildCustomIconMenuItem,
        TOGGLE_ITEM => :BuildToggleMenuItem
    };

    function BuildMenuItem(params as MenuItemProps, valueKey as MenuValueKey?) as WatchUi.MenuItem {
        return new WatchUi.MenuItem(
            params.get(:label),
            params.get(:subLabel),
            params.get(:identifier),
            params.get(:options)
        );
    }

    function BuildCustomColorMenuItem(
        params as CustomColorMenuItemProps,
        valueKey as MenuValueKey?
    ) as CustomColorMenuItem {
        return new CustomColorMenuItem(params);
    }

    function BuildCustomIconMenuItem(
        params as CustomIconMenuItemProps,
        valueKey as MenuValueKey?
    ) as CustomIconMenuItem {
        return new CustomIconMenuItem(params);
    }

    function BuildToggleMenuItem(params as ToggleItemProps, valueKey as MenuValueKey?) as WatchUi.ToggleMenuItem {
        var isEnabled = params.get(:enabled);

        if (valueKey != null) {
            isEnabled = SettingsModule.getValue(valueKey);
        }

        if (isEnabled == null) {
            isEnabled = false;
        }

        var label = WatchUi.loadResource(params.get(:label));
        var subLabel = params.get(:subLabel);
        subLabel = subLabel != null ? WatchUi.loadResource(subLabel) : null;

        return new WatchUi.ToggleMenuItem(label, subLabel, params.get(:identifier), isEnabled, params.get(:options));
    }
}
