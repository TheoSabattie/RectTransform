package com;
import com.Vector2;

/**
 * ...
 * @author Théo Sabattié
 */
class Rect implements IRectSize
{    
    public var min(default, null):Vector2 = new Vector2();
    public var max(default, null):Vector2 = new Vector2();
    
    public var xMin(get, set):Float;
    public var xMax(get, set):Float;
    public var yMin(get, set):Float;
    public var yMax(get, set):Float;
    
    public var width(get, set):Float;
    public var height(get, set):Float;
    
    public function new() 
    {
    }
    
    public function setCenter(center:Vector2):Rect {
        var halfWidth:Float  = width / 2;
        var halfHeight:Float = height / 2;
        
        min.setXY(center.x - halfWidth, center.y - halfHeight);
        max.setXY(center.x + halfWidth, center.y + halfHeight);
        
        return this;
    }
    
    public function getCenter():Vector2 { return Vector2.addition(min, max).divide(2); }
    
    public function setSize(size:IRectSize):Rect {
        var center:Vector2   = getCenter();
        var halfWidth:Float  = size.width / 2;
        var halfHeight:Float = size.height / 2;
        
        min.setXY(center.x - halfWidth, center.y - halfHeight);
        max.setXY(center.x + halfWidth, center.y + halfHeight);
        
        return this;
    }
    
    public function getSize():IRectSize { return new RectSize(width, height); }
    
    private function set_xMin(xMin:Float):Float {
        return min.x = xMin;
    }
    
    private function set_xMax(xMax:Float):Float {
        return max.x = xMax;
    }
    
    private function set_yMin(yMin:Float):Float {
        return min.y = yMin;
    }
    
    private function set_yMax(yMax:Float):Float {
        return max.y = yMax;
    }
    
    private function set_width(width:Float):Float {
        var center:Float = min.x + (max.x - min.x) / 2;
        
        var halfWidth:Float = width/2;
        min.x = center - halfWidth;
        max.x = center + halfWidth;
        
        return width;
    }
    
    private function set_height(height:Float):Float {
        var center:Float = min.y + (max.y - min.y) / 2;
        
        var halfHeight:Float = height/2;
        min.y = center - halfHeight;
        max.y = center + halfHeight;
        
        return height;
    }
    
    private function get_xMin():Float { return min.x; }
    private function get_xMax():Float { return max.x; }

    private function get_yMin():Float { return min.y; }
    private function get_yMax():Float { return max.y; }
    
    private function get_min():Vector2 { return min; }
    private function get_max():Vector2 { return max; }
    
    private function get_width():Float { return max.x - min.x; }
    private function get_height():Float { return max.y - min.y; }
}