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
    
    public var xMin(get, set):Float;
    public var xMax(get, set):Float;
    public var yMin(get, set):Float;
    public var yMax(get, set):Float;
    
    public var center(get, set):Vector2;
    
    public var size(get, set):RectSize;
    public var width(get, set):Float;
    public var height(get, set):Float;
    
    public function new() 
    {
        
    }
    
    private function set_xMin(xMin:Float):Float {
        return _min.x = xMin;
    }
    
    private function set_xMax(xMax:Float):Float {
        return _max.x = xMax;
    }
    
    private function set_yMin(yMin:Float):Float {
        return _min.y = yMin;
    }
    
    private function set_yMax(yMax:Float):Float {
        return _max.y = yMax;
    }
    
    private function set_min(min:Vector2):Vector2 {
        return _min = min;
    }
    
    private function set_max(max:Vector2):Vector2 {
        return _max = max; 
    }
    
    private function set_size(size:RectSize):RectSize {
        width  = size.width;
        height = size.height;
        
        return size;
    }
    
    private function set_width(width:Float):Float {
        var demiWidthDiff:Float = (width - this.width)/2;
        _min.x -= demiWidthDiff;
        _max.x += demiWidthDiff;
        
        return width;
    }
    
    private function set_height(height:Float):Float {
        var demiHeightDiff:Float = (height - this.height)/2;
        _min.x -= demiHeightDiff;
        _max.x += demiHeightDiff;
        
        return height;
    }
    
    private function set_center(center:Vector2):Vector2 {
        var centerDiff:Vector2 = Vector2.subtraction(this.center, center); 
        min.subtract(centerDiff);
        max.subtract(centerDiff);
        
        return center;
    }
    
    private function get_size():RectSize { return new RectSize(width, height); }
    
    private function get_xMin():Float { return _min.x; }
    private function get_xMax():Float { return _max.x; }

    private function get_yMin():Float { return _min.y; }
    private function get_yMax():Float { return _max.y; }
    
    private function get_center():Vector2 { return Vector2.addition(min, max).divide(2); }
    
    private function get_min():Vector2 { return _min; }
    private function get_max():Vector2 { return _max; }
    
    private function get_width():Float { return _max.x - _min.x; }
    private function get_height():Float { return _max.y - _min.y; }
}