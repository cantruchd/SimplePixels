import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Graphics;
import Toybox.System;
import PositionUtils;
import ResourcesCache;
import GlobalKeys;

module Components {
    typedef BoxProps as {
        :boxWidth as String?,
        :boxHeight as String?,
        :xPos as String?,
        :yPos as String?,
        :xShift as String?,
        :yShift as String?,
        :horizontalAlignment as PositionUtils.AlignmentEnum?,
        :verticalAlignment as PositionUtils.AlignmentEnum?,
        :font as ResourceId?,
        :debug as Boolean?
    };

    class Box extends BaseDrawable {
        (:debug)
        private var DEBUG_LINE_SIZE = 2;
        private var _font as ResourceId?;
        private var _boxWidth as Numeric? = null;
        private var _boxHeight as Numeric? = null;
        private var _posY as Numeric? = null;
        private var _posX as Numeric? = null;

        protected var _debug as Boolean;

        function initialize(params as BoxProps) {
            self.calcActualBoxSize(params);
            self.calcPosition(params);

            BaseDrawable.initialize(params);

            var font = params.get(:font);
            self._font = font != null ? font : null;

            var debug = params.get(:debug);
            self._debug = debug != null ? debug : false;
        }

        private function calcActualBoxSize(params as BoxProps) as Void {
            var boxWidth = params.get(:boxWidth);
            boxWidth = boxWidth != null ? boxWidth : "0";

            var boxHeight = params.get(:boxHeight);
            boxHeight = boxHeight != null ? boxHeight : "0";

            self._boxWidth = self.parseActualSize(boxWidth, GlobalKeys.SCREEN_WIDTH);
            self._boxHeight = self.parseActualSize(boxHeight, GlobalKeys.SCREEN_HEIGHT);
        }

        private function calcPosition(params as BoxProps) as Void {
            self._posX = self.calcHorizontalAlignment(params);
            self._posY = self.calcVerticalAlignment(params);
        }

        protected function getFont() as Resource or Number {
            if (self._font == Graphics.FONT_NUMBER_MEDIUM)
            {
                return Graphics.FONT_NUMBER_MEDIUM;
            }

            if (self._font == Graphics.FONT_XTINY)
            {
                return Graphics.FONT_XTINY;
            }
        
            return self._font != null ? ResourcesCache.get(self._font) : Graphics.FONT_MEDIUM;
        }

        protected function getWidth() as Number {
            return self._boxWidth as Number;
        }

        protected function getHeight() as Number {
            return self._boxHeight as Number;
        }

        protected function getPosX() as Number {
            return self._posX as Number;
        }

        protected function getPosY() as Number {
            return self._posY as Number;
        }

        protected function parseActualSize(position as String, size as Number) as Numeric {
            return PositionUtils.parsePosition(position, size);
        }

        private function calcXPoint(xPos as String) as Numeric {
            return self.parseActualSize(xPos, GlobalKeys.SCREEN_WIDTH);
        }

        private function calcXShift(xShift as String) as Numeric {
            return self.parseActualSize(xShift, GlobalKeys.SCREEN_WIDTH);
        }

        private function calcYPoint(yPos as String) as Numeric {
            return self.parseActualSize(yPos, GlobalKeys.SCREEN_HEIGHT);
        }

        private function calcYShift(yShift as String) as Numeric {
            return self.parseActualSize(yShift, GlobalKeys.SCREEN_HEIGHT);
        }

        private function calcHorizontalAlignment(params as BoxProps) as Numeric {
            var horizontalAlignment = params.get(:horizontalAlignment);
            horizontalAlignment = horizontalAlignment != null ? horizontalAlignment : PositionUtils.ALIGN_START;

            var xPos = params.get(:xPos);
            xPos = xPos != null ? xPos : "0";

            var xShift = params.get(:xShift);
            xShift = xShift != null ? xShift : "0";

            var position = self.calcXPoint(xPos);
            var shift = self.calcXShift(xShift);
            var width = self.getWidth();

            return position - PositionUtils.calcAlignmentShift(horizontalAlignment, width) + shift;
        }

        private function calcVerticalAlignment(params as BoxProps) as Numeric {
            var verticalAlignment = params.get(:verticalAlignment);
            verticalAlignment = verticalAlignment != null ? verticalAlignment : PositionUtils.ALIGN_START;

            var yPos = params.get(:yPos);
            yPos = yPos != null ? yPos : "0";

            var yShift = params.get(:yShift);
            yShift = yShift != null ? yShift : "0";

            var position = self.calcYPoint(yPos);
            var shift = self.calcYShift(yShift);
            var height = self.getHeight();

            return position - PositionUtils.calcAlignmentShift(verticalAlignment, height) + shift;
        }

        (:debug)
        private function renderDebugArea(drawContext as Dc) as Void {
            var debugPosX = self.getPosX() - self.DEBUG_LINE_SIZE;
            var debugPosY = self.getPosY() - self.DEBUG_LINE_SIZE;
            var debugBoxWidth = self.getWidth() + self.DEBUG_LINE_SIZE * 2;
            var debugBoxHeight = self.getHeight() + self.DEBUG_LINE_SIZE * 2;

            drawContext.setClip(debugPosX, debugPosY, debugBoxWidth, debugBoxHeight);
            drawContext.setColor(Graphics.COLOR_RED, Graphics.COLOR_GREEN);
            drawContext.setPenWidth(self.DEBUG_LINE_SIZE);
            drawContext.fillRectangle(debugPosX, debugPosY, debugBoxWidth, debugBoxHeight);
        }

        private function clipRenderArea(drawContext as Dc) as Void {
            drawContext.setClip(self.getPosX(), self.getPosY(), self.getWidth(), self.getHeight());
        }

        protected function onRenderBefore(drawContext as Dc) as Void {
            if (!self.isVisible) {
                return;
            }

            if (drawContext has :setAntiAlias) {
                drawContext.setAntiAlias(true);
            }

            self.clipRenderArea(drawContext);
        }

        protected function render(drawContext as Dc) as Void {
            // Abstract
        }

        (:debug)
        function draw(drawContext as Dc) as Void {
            self.onRenderBefore(drawContext);

            if (!self.isVisible) {
                return;
            }

            if (self._debug) {
                self.renderDebugArea(drawContext);
            }

            self.render(drawContext);
        }

        (:release)
        function draw(drawContext as Dc) as Void {
            self.onRenderBefore(drawContext);

            if (!self.isVisible) {
                return;
            }

            self.render(drawContext);
        }
    }
}
