package com;
import js.html.ParagraphElement;

/**
 * ...
 * @author Théo Sabattié
 */
class RectTransform
{
    public static var resizeMode:ResizeMode = ResizeMode.FROM_MIN;
    public static var windowReferenceSize(default, null):IRectSize = new RectSize(1920, 1080);
    public static var windowSize(default, null):RectSize = new RectSize();
    private static var roots:Array<RectTransform> = [];
    
    private var _parent:RectTransform;
    private var _children:Array<RectTransform> = [];
    
    public var anchorMin(default, null):Vector2        = new Vector2(0, 0);
    public var anchorMax(default, null):Vector2        = new Vector2(1, 1);
    public var anchoredPosition(default, null):Vector2 = new Vector2(0, 0);
    public var sizeDelta(default, null):RectSize       = new RectSize(0, 0);
    public var pivot(default, null):Vector2            = new Vector2(0.5, 0.5);
    public var localScale(default, null):Vector2       = new Vector2(1, 1);
    
    public var index(get, set):Int;
    public var parent(get, set):RectTransform;
    public var invertY:Bool = false;
    
    public function new()
    {
        parent = null;
    }
    
    private function get_parent():RectTransform 
    {
        return _parent;
    }
    
    public static function getWindowScale():Vector2 {
        var widthRatio:Float  = windowSize.width / windowReferenceSize.width;
        var heightRatio:Float = windowSize.height / windowReferenceSize.height;
        var ratio:Float;
        
        switch(resizeMode) {
            case ResizeMode.FROM_MAX:
                ratio = Math.max(widthRatio, heightRatio);
            case ResizeMode.FROM_MIN:
                ratio = Math.min(widthRatio, heightRatio);
            default:
                ratio = 1;
        }
        
        return new Vector2(ratio, ratio);
    }
    
    private function getParentScale():Vector2 {
        return _parent == null? getWindowScale() : _parent.getScale();
    }
    
    public function getScale():Vector2 {
        return localScale.clone().multiVec(getParentScale());
    }
    
    public function getAnchorRect():Rect {
        var parentSize:IRectSize = getParentSize();
        var anchorRect:Rect      = new Rect();
        
        anchorRect.min.setXY(parentSize.width * anchorMin.x, parentSize.height * anchorMin.y);
        anchorRect.max.setXY(parentSize.width * anchorMax.x, parentSize.height * anchorMax.y);
        
        return anchorRect;
    }
    
    public function getRect():Rect {
        var width:Float            = getWidth();
        var height:Float           = getHeight();
        var rect:Rect              = new Rect();
        var scale:Vector2          = getScale();
        var anchorPosition:Vector2 = getAnchorCenter().add(anchoredPosition.multiVec(scale));
        
        rect.xMin = anchorPosition.x - width * scale.x * pivot.x;
        rect.yMin = (invertY) ? anchorPosition.y - height * scale.y * (1-pivot.y) : anchorPosition.y - height * scale.y * pivot.y;
        rect.max.setXY(rect.xMin + width * scale.x, rect.yMin + height * scale.y);
        
        trace( {
            windowWidth  : windowSize.width,
            windowHeight : windowSize.height,
            rect         : rect,
            anchorCenter : getAnchorCenter(),
            scale        : scale
        });
        
        return rect;
    }
    
    public function getParentSize():IRectSize {
        if (_parent == null) return new RectSize(windowSize.width, windowSize.height);
        return new RectSize(_parent.getWidth(), _parent.getHeight());
    }
    
    public function getParentWidth():Float {
        return _parent == null ? windowSize.width : _parent.getWidth();
    }
    
    public function getParentHeight():Float {
        return _parent == null ? windowSize.height : _parent.getHeight();
    }
    
    public function getAnchorCenter():Vector2 {
        var parentWidth:Float  = getParentWidth();
        var parentHeight:Float = getParentHeight();
        
        return new Vector2(anchorMin.x * parentWidth + getAnchorWidth() / 2, (invertY ? 1 - anchorMin.y : anchorMin.y) * parentHeight + getAnchorHeight() / 2);
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