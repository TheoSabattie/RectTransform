package com;

/**
 * ...
 * @author Théo Sabattié
 */
class RectTransform
{
    public static var windowWidth:Float;
    public static var windowHeight:Float;
    private static var roots:Array<RectTransform> = [];
    
    private var _parent:RectTransform;
    private var _children:Array<RectTransform> = [];
    
    public var anchorMin(default, null):Vector2        = new Vector2(0, 0);
    public var anchorMax(default, null):Vector2        = new Vector2(1, 1);
    public var anchoredPosition(default, null):Vector2 = new Vector2(0, 0);
    public var sizeDelta(default, null):RectSize       = new RectSize(0, 0);
    public var pivot(default, null):Vector2            = new Vector2(0.5, 0.5);
    
    public var index(get, set):Int;
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
        var width:Float            = this.width;
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
    
    public function getChildren():Array<RectTransform> {
        return _children.slice(0);
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
        if (parent == _parent) return parent;
        if (_parent != null) _parent._children.remove(this);
        if (parent != null) {
            roots.remove(this);
            parent._children.push(this);
        }
        else roots.push(this);
        
        return _parent = parent;
    }
    
    private function get_index():Int {
        return _parent != null ? _parent._children.indexOf(this) : roots.indexOf(this);
    }
    
    private function set_index(index:Int):Int {
        var container:Array<RectTransform> = (_parent != null) ? _parent._children : roots;
        container.remove(this);
        container.insert(index, this);
        
        return container.indexOf(this);
    }
    
    public function destroy():Void {
        for (child in _children) child.destroy();
        
        if (parent != null) parent._children.remove(this);
    }
}