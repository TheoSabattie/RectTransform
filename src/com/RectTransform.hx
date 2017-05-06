package com;

/**
 * ...
 * @author Théo Sabattié
 */
class RectTransform
{
    public static var windowWidth(default, set):Float  = 0;
    public static var windowHeight(default, set):Float = 0;
    private static var roots:Array<RectTransform> = [];
    
    private var _parent:RectTransform;
    private var _children:Array<RectTransform>;
    
    public var anchorMin(default, null):Vector2        = new Vector2(0, 0);
    public var anchorMax(default, null):Vector2        = new Vector2(1, 1);
    public var anchoredPosition(default, null):Vector2 = new Vector2(0, 0);
    public var sizeDelta(default, null):RectSize       = new RectSize(0, 0);
    public var pivot(default, null):Vector2            = new Vector2(0.5, 0.5);
    
    public var parent(get, set):RectTransform;
    public var width(get, never):Float;
    public var height(get, never):Float;
    public var anchorWidth(get, never):Float;
    public var anchorHeight(get, never):Float;
    
    public function new()
    {
        parent = null;
    }
    
    private function get_parent():RectTransform 
    {
        return _parent;
    }
    
    public function getRect():Rect {
        var width:Float            = this.height;
        var height:Float           = this.height;
        var anchorPosition:Vector2 = getAnchorCenter().add(anchoredPosition);
        var rect:Rect              = new Rect();
        
        rect.xMin = anchorPosition.x - width * pivot.x;
        rect.yMin = anchorPosition.y - height * pivot.y;
        rect.max.setXY(rect.xMin + width, rect.yMin + height);
        
        return rect;
    }
    
    public function getAnchorCenter():Vector2 {
        return new Vector2(anchorMin.x + anchorWidth / 2, anchorMin.y + anchorHeight / 2);
    }
    
    private function get_anchorWidth():Float {
        if (_parent == null) {
            return windowWidth * (anchorMax.x - anchorMin.x);
        }
        
        return _parent.width * (anchorMax.x - anchorMin.x);
    }
    
    private function get_anchorHeight():Float {
        if (_parent == null) {
            return windowHeight * (anchorMax.y - anchorMin.y);
        }
        
        return _parent.height * (anchorMax.y - anchorMin.y);
    }
    
    private function get_width():Float 
    {
        return anchorWidth + sizeDelta.width;
    }
    
    private function get_height():Float 
    {
        return anchorHeight + sizeDelta.height;
    }
    
    private function set_parent(parent:RectTransform):RectTransform 
    {
        if (_parent == null) {
            if (roots.indexOf(this) == -1) roots.push(this);
        } else {
            roots.remove(this);
        }
        
        return _parent = parent;
    }
    
    private static function set_windowWidth(windowWidth:Float):Float 
    {
        return RectTransform.windowWidth = windowWidth;
    }
    
    private static function set_windowHeight(windowHeight:Float):Float 
    {
        return RectTransform.windowWidth = windowHeight;
    }
}