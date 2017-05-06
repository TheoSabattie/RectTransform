package com;

/**
 * ...
 * @author Théo Sabattié
 */
class Vector2
{
    public var x:Float;
    public var y:Float;
    public var magnitude(get, set):Float;
    
    public function new(x:Float = 0, y:Float = 0) 
    {
        this.x = x;
        this.y = y;
    }
    
    public function setXY(x:Float, y:Float):Vector2 {
        this.x = x;
        this.y = y;
        
        return this;
    }
    
    public function add(additiveVector:Vector2):Vector2 {
        x += additiveVector.x;
        y += additiveVector.y;
        
        return this;
    }
    
    public function subtract(subtractiveVector:Vector2):Vector2 {
        x -= subtractiveVector.x;
        y -= subtractiveVector.y;
        
        return this;
    }
    
    public function normalize(magnitude:Float = 1):Vector2 {
        this.magnitude = magnitude;
        
        return this;
    }
    
    public function divide(diviser:Float):Vector2
    {
        x /= diviser;
        y /= diviser;
        
        return this;
    }
    
    public function clone():Vector2 {
        return new Vector2(x, y);
    }
    
    private function get_magnitude():Float { return Math.sqrt(x * x + y * y);}
    
    private function set_magnitude(magnitude:Float):Float {
        var multiplicator:Float = magnitude / get_magnitude();
        
        x *= multiplicator;
        y *= multiplicator;
        
        return magnitude;
    }
    
    public static function cloneAndNormalize(vector:Vector2):Vector2 {
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