package com;

/**
 * ...
 * @author Théo Sabattié
 */
class RectTransform
{
    public static var resizeMode(default, set):ResizeMode = ResizeMode.FROM_MIN;
    private static var _windowReferenceSize:RectSize = new RectSize(1920, 1080);
    private static var _windowSize:RectSize          = new RectSize();

    private static function updateRoots():Void { for (i in 0...roots.length) roots[i].onUpdate(); }
    
    public static function getWindowRefenceSize():RectSize { return _windowReferenceSize.clone();}
    public static function getWindowSize():RectSize { return _windowSize.clone(); }

    public static function setWindowReferenceSize(windowReferenceSize:IRectSize):IRectSize {
        _windowReferenceSize.setWidthHeight(windowReferenceSize.width, windowReferenceSize.height);
        updateRoots();
        return windowReferenceSize;
    }
    
    public static function setWindowSize(windowSize:IRectSize):IRectSize {
        _windowSize.setWidthHeight(windowSize.width, windowSize.height);
        updateRoots();
        return windowSize;
    }
    
    /**
     * All rectransform at the top of the hierachy, without parent
     */
    private static var roots:Array<RectTransform> = [];
    
    private static function set_resizeMode(resizeMode:ResizeMode):ResizeMode {
        if (RectTransform.resizeMode == resizeMode)
            return resizeMode;
            
        RectTransform.resizeMode = resizeMode;
        updateRoots();
        return resizeMode;
    }
    
    private function onUpdate():Void 
    {
        emitOnUpdate();
        
        for (i in 0..._children.length) _children[i].onUpdate(); 
    }
    
    public var onUpdatedListeners(default, null):Array<RectTransform->Void> = [];
    
    private var _parent:RectTransform;
    private var _children:Array<RectTransform> = [];
    
    private var _anchorMin(default, null):Vector2        = new Vector2(0, 0);
    private var _anchorMax(default, null):Vector2        = new Vector2(1, 1);
    private var _anchoredPosition(default, null):Vector2 = new Vector2(0, 0);
    private var _sizeDelta(default, null):RectSize       = new RectSize(0, 0);
    private var _pivot(default, null):Vector2            = new Vector2(0.5, 0.5);
    private var _localScale(default, null):Vector2       = new Vector2(1, 1); 
    
    /**
     * Return the position as child in its local hierarchy
     */
    public var index(get, set):Int;
    
    /**
     * By default {y : 0} begin at the top of the screen, if invertY is true, {y : 0} will begin at the bottom of the screen
     */
    public var invertY:Bool = false;

    public var parent(get, set):RectTransform;
    
    public function new()
    {
        roots.push(this);
    }
        
    public static function getWindowScale():Vector2 {
        var widthRatio:Float  = _windowSize.width / _windowReferenceSize.width;
        var heightRatio:Float = _windowSize.height / _windowReferenceSize.height;
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
    
    public function getAnchorMin():Vector2 {
        return _anchorMin.clone();
    }
    
    public function getAnchorMax():Vector2 {
        return _anchorMax.clone();
    }
    
    public function getAnchoredPosition():Vector2 {
        return _anchoredPosition.clone();
    }
    
    public function getSizeDelta():RectSize {
        return _sizeDelta.clone();
    }
    
    public function getPivot():Vector2 {
       return _pivot.clone(); 
    }
    
    public function getLocalScale():Vector2 {
       return _localScale.clone(); 
    }
    
    public function setAnchorMin(anchorMin:Vector2):RectTransform {
        _anchorMin.setXY(anchorMin.x, anchorMin.y);
        onUpdate();
        return this;
    }
    
    public function setAnchorMax(anchorMax:Vector2):RectTransform {
        _anchorMax.setXY(anchorMax.x, anchorMax.y);
        onUpdate();
        return this;
    }
    
    public function setAnchoredPosition(anchoredPosition:Vector2):RectTransform {
        _anchoredPosition.setXY(anchoredPosition.x, anchoredPosition.y);
        onUpdate();
        return this;
    }
    
    public function setSizeDelta(sizeDelta:IRectSize):RectTransform {
        _sizeDelta.setWidthHeight(sizeDelta.width, sizeDelta.height);
        onUpdate();
        return this;
    }
    
    public function setPivot(pivot:Vector2):RectTransform {
        _pivot.setXY(pivot.x, pivot.y);
        onUpdate();
        return this;
    }
    
    public function setLocalScale(localScale:Vector2):RectTransform {
        _localScale.setXY(localScale.x, localScale.y);
        onUpdate();
        return this;
    }
    
    private function getParentScale():Vector2 {
        return _parent == null? getWindowScale() : _parent.getScale();
    }
    
    public function getScale():Vector2 {
        return _localScale.clone().multiVec(getParentScale());
    }
    
    /**
     * Computed Rect from anchor min and anchor max based from parent if exist or from window size if parent does not exist
     * @return
     */
    public function getAnchorRect():Rect {
        var parentSize:IRectSize = getParentSize();
        var anchorRect:Rect      = new Rect();
        
        anchorRect.min.setXY(parentSize.width * _anchorMin.x, parentSize.height * _anchorMin.y);
        anchorRect.max.setXY(parentSize.width * _anchorMax.x, parentSize.height * _anchorMax.y);
        
        return anchorRect;
    }
    
    /**
     * Final computed Rect from anchorRect + anchoredPosition + sizeDelta
     * @return
     */
    public function getRect():Rect {
        var rect:Rect        = getAnchorRect();
        var scale:Vector2    = getScale();
        var position:Vector2 = _anchoredPosition.clone().multiVec(scale);
        
        rect.max.add(position);
        rect.min.add(position);
        
        rect.width  += _sizeDelta.width * scale.x;
        rect.height += _sizeDelta.height * scale.y;
        
        return rect;
    }
    
    public function getParentSize():RectSize {
        return (_parent != null) ? _parent.getSize() : new RectSize(_windowSize.width, _windowSize.height);
    }
    
    private function emitOnUpdate():Void { for (i in 0...onUpdatedListeners.length) onUpdatedListeners[i](this); }
    
    private function getAnchorCenter():Vector2 {
        var anchorRect:Rect = getAnchorRect();
        return anchorRect.min.add(anchorRect.max.subtract(anchorRect.min).divide(2));
    }
    
    public function getChildren():Array<RectTransform> {
        return _children.slice(0);
    }
    
    private function getAnchorSize():RectSize {
        var parentSize:RectSize = getParentSize();
        return new RectSize(parentSize.width * (_anchorMax.x - _anchorMin.x), parentSize.height * (_anchorMax.y - _anchorMin.y));
    }
    
    private function getSize():RectSize {
       var scale:Vector2 = getScale();
       var anchorSize:RectSize = getAnchorSize();
       return new RectSize(anchorSize.width + _sizeDelta.width * scale.x, anchorSize.height + _sizeDelta.height * scale.y);
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
        
        onUpdate();
        
        return _parent = parent;
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
    
    public function toObject() 
    {
        return {
            parentSize       : getParentSize(),
            anchorMin        : _anchorMin,
            anchorMax        : _anchorMax,
            pivot            : _pivot,
            anchoredPosition : _anchoredPosition,
            anchorRect       : getAnchorRect(),
            localScale       : _localScale,
            anchorCenter     : getAnchorCenter(),
            scale            : getScale(),
            rect             : getRect()
        };
    }
    
    private function get_index():Int { return _parent != null ? _parent._children.indexOf(this) : roots.indexOf(this); }
    private function get_parent():RectTransform { return _parent; }
}