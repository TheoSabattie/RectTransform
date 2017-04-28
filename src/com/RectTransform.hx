package com;

/**
 * ...
 * @author Théo Sabattié
 */
class RectTransform
{
    private var _parent:RectTransform;
    private var _left:Float;
    private var _top:Float;
    private var _right:Float;
    private var _bottom:Float;
    private var _width:Float;
    private var _height:Float;
    private var _anchor:Rect;
    private var _pivot:Vector2;
    
    public var parent(get, set):RectTransform;
    
    public var left(get, set):Float;
    public var top(get, set):Float;
    public var right(get, set):Float;
    public var bottom(get, set):Float;
    
    public var width(get, set):Float;
    public var height(get, set):Float;
    
    public var anchor(get, set):Rect;
    public var pivot(get, set):Vector2;
    
    public function new()
    {
        
    }
    
    private function get_parent():RectTransform 
    {
        return _parent;
    }
    
    private function get_left():Float 
    {
        return _left;
    }
    
    private function get_top():Float 
    {
        return _top;
    }
    
    private function get_right():Float 
    {
        return _right;
    }
    
    private function get_bottom():Float 
    {
        return _bottom;
    }
    
    private function get_width():Float 
    {
        return _width;
    }
    
    private function get_height():Float 
    {
        return _height;
    }
    
    private function get_anchor():Rect 
    {
        return _anchor;
    }
    
    private function get_pivot():Vector2 
    {
        return _pivot;
    }
    
    private function set_parent(parent:RectTransform):RectTransform 
    {
        return _parent = parent;
    }
    
    private function set_left(left:Float):Float 
    {
        return _left = left;
    }
    
    private function set_top(top:Float):Float 
    {
        return _top = top;
    }
    
    private function set_right(right:Float):Float 
    {
        return _right = right;
    }
    
    private function set_bottom(bottom:Float):Float 
    {
        return _bottom = bottom;
    }
    
    private function set_width(width:Float):Float 
    {
        return _width = width;
    }
    
    private function set_height(height:Float):Float 
    {
        return _height = height;
    }
    
    private function set_anchor(anchor:Rect):Rect 
    {
        return _anchor = anchor;
    }
    
    private function set_pivot(pivot:Vector2):Vector2 
    {
        return _pivot = pivot;
    }
    
    
}