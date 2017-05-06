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
    
    public var onUpdatedListeners(default, null):Array<Vector2->Void> = [];
    public var x(get, set):Float;
    public var y(get, set):Float;
    public var magnitude(get, set):Float;
    
    public function new(x:Float = 0, y:Float = 0) 
    {
        _x = x;
        _y = y;
    }
    
    public function setXY(x:Float, y:Float):Vector2 {
        _x = x;
        _y = y;
        
        emitUpdated();
        
        return this;
    }
    
    private function emitUpdated():Void {
        for (i in 0...onUpdatedListeners.length) {
            onUpdatedListeners[i](this);
        }
    }
    
    public function add(additiveVector:Vector2):Vector2 {
        _x += additiveVector.x;
        _y += additiveVector.y;
        
        emitUpdated();
        
        return this;
    }
    
    public function subtract(subtractiveVector:Vector2):Vector2 {
        _x -= subtractiveVector.x;
        _y -= subtractiveVector.y;
        
        emitUpdated();
        
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
        
        emitUpdated();
        
        return this;
    }
    
    public function clone():Vector2 {
        return new Vector2(_x, _y);
    }
    
    private function get_magnitude():Float { return Math.sqrt(x * x + y * y);}
    
    private function set_magnitude(magnitude:Float):Float {
        var multiplicator:Float = magnitude / get_magnitude();
        
        _x *= multiplicator;
        _y *= multiplicator;
        
        emitUpdated();
        
        return magnitude;
    }
    
    private function get_x():Float {
        return _x;
    }
    
    private function set_x(x:Float):Float {
        _x = x;
        emitUpdated();
        
        return _x;
    }
    
    private function get_y():Float {
       return _y; 
    }
    
    private function set_y(y:Float):Float {
        _y = y;
        emitUpdated();
        
        return _y;
    }
    
    public static function cloneAndNormalize(vector:Vector2):Vector2 {
        return vector.clone().normalize();
    }
    
    public static function addition(vector:Vector2, additiveVector:Vector2):Vector2 
    {
        return new Vector2(vector._x + additiveVector._x, vector._y + additiveVector._y);
    }
    
    public static function subtraction(vector:Vector2, subtractiveVector:Vector2):Vector2 {
        return new Vector2(vector._x - subtractiveVector._x, vector._y - subtractiveVector._y);
    }
}