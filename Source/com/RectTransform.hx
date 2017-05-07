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
    
    public function new()
    {
        parent = null;
    }
    
    private function get_parent():RectTransform 
    {
        return _parent;
    }
    
    public var invertY:Bool = false;
    
    public function getRect():Rect {
        var width:Float            = getWidth();
        var height:Float           = getHeight();
        var anchorPosition:Vector2 = getAnchorCenter().add(anchoredPosition);
        var rect:Rect              = new Rect();
        
        rect.xMin = anchorPosition.x - width * pivot.x;
        rect.yMin = (invertY) ? anchorPosition.y + height * (1-pivot.y) : anchorPosition.y - height * pivot.y;
        rect.max.setXY(rect.xMin + width, rect.yMin + height);
        
        trace( {
            windowWidth  : RectTransform.windowWidth,
            windowHeight : RectTransform.windowHeight,
            rect         : rect,
            anchorCenter : getAnchorCenter()
        });
        
        return rect;
    }
    
    public function getParentWidth():Float {
        return _parent == null ? windowWidth : _parent.getWidth();
    }
    
    public function getParentHeight():Float {
        return _parent == null ? windowHeight : _parent.getHeight();
    }
    
    public function getAnchorCenter():Vector2 {
        var parentWidth:Float  = getParentWidth();
        var parentHeight:Float = getParentHeight();
        
        return new Vector2(anchorMin.x * parentWidth + getAnchorWidth() / 2, anchorMin.y * parentHeight + getAnchorHeight() / 2);
    }
    
    public function getChildren():Array<RectTransform> {
        return _children.slice(0);
    }
    
    private function getAnchorWidth():Float {
        return getParentWidth() * (anchorMax.x - anchorMin.x);
    }
    
    private function getAnchorHeight():Float {
        return getParentHeight() * (anchorMax.y - anchorMin.y);
    }
    
    private function getWidth():Float 
    {
        return getAnchorWidth() + sizeDelta.width;
    }
    
    private function getHeight():Float 
    {
        return getAnchorHeight() + sizeDelta.height;
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