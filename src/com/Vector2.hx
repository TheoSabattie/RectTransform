package com;
import com.Vector2;
import haxe.ds.Vector;

/**
 * ...
 * @author Théo Sabattié
 */
class Vector2
{
    private var _x:Float;
    private var _y:Float;
    
    public var x(get, set):Float;
    public var y(get, set):Float;
    public var magnitude(get, set):Float;
    
    public function new(x:Float = 0, y:Float = 0) 
    {
        _x = x;
        _y = y;
    }
    
    private function get_x():Float { return _x; }
    private function get_y():Float { return _y; }
    private function get_magnitude():Float { return Math.sqrt(_x * _x + _y * _y);}
    
    private function set_x(x:Float):Float {
        return _x = x;
    }
    
    private function set_y(y:Float):Float {
        return _y = y;
    }
    
    private function set_magnitude(magnitude:Float):Float {
        var multiplicator:Float = magnitude / get_magnitude();
        
        _x *= multiplicator;
        _y *= multiplicator;
        
        return magnitude;
    }

    
    
    public function add(additiveVector:Vector2):Vector2 {
        _x += additiveVector.x;
        _y += additiveVector.y;
        return this;
    }
    
    public function subtract(subtractiveVector:Vector2):Vector2 {
        _x -= subtractiveVector.x;
        _y -= subtractiveVector.y;
        return this;
    }
    
    public function normalize(magnitude:Float = 1):Vector2 {
        this.magnitude = magnitude;
        return this;
    }
    
    public function divide(diviser:Float):Vector2
    {
        _x /= diviser;
        _y /= diviser;
        return this;
    }
    
    private function clone():Vector2 {
        return new Vector2(_x, _y);
    }
    
    
    
    private static function cloneAndNormalize(vector:Vector2):Vector2 {
        return vector.clone().normalize();
    }
    
    public static function addition(vector:Vector2, additiveVector:Vector2):Vector2 
    {
        return new Vector2(vector.x + additiveVector.x, vector.y + additiveVector.y);
    }
    
    public static function subtraction(vector:Vector2, subtractiveVector:Vector2):Vector2 {
        return new Vector2(vector.x - subtractiveVector.x, vector.y - subtractiveVector.y);
    }
}