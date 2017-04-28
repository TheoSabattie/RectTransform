package com;

/**
 * ...
 * @author Théo Sabattié
 */
class Rect implements IRectSize
{
    private var _min:Vector2 = new Vector2();
    private var _max:Vector2 = new Vector2();
    
    public var min(get, set):Vector2;
    public var max(get, set):Vector2;
    
    public var width(get, set):Float;
    public var height(get, set):Float;
    
    public function new() 
    {
        
    }
    
    private function set_min(min:Vector2):Vector2 {
        return _min = min;
    }
    
    private function set_max(max:Vector2):Vector2 {
        return _max = max; 
    }
    
    private function set_width(width:Float):Float {
        throw "not implemented";
    }
    
    private function set_height(height:Float):Float {
        throw "not implemented";
    }
    
    private function get_min():Vector2 { return _min; }
    private function get_max():Vector2 { return _max; }
    private function get_width():Float { return _max.x - _min.x; }
    private function get_height():Float { return _max.y - _min.y; }
}