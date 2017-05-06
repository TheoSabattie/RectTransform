package com;

/**
 * ...
 * @author Théo Sabattié
 */
class RectSize implements IRectSize
{
    private var _width:Float;
    private var _height:Float;
    
    public var width(get, set):Float;
    public var height(get, set):Float;
    
    public function new(width:Float = 0, height:Float = 0) 
    {
        this.width  = width;
        this.height = height;
    }
    
    public function SetWidthHeight(width:Float, height:Float):RectSize {
        this.width  = width;
        this.height = height;
        
        return this;
    }
    
    public function clone():RectSize {
        return new RectSize(_width, _height);
    }
    
    private function get_height():Float 
    {
        return _height;
    }
    
    private function get_width():Float 
    {
        return _width;
    }
    
    private function set_width(width:Float):Float 
    {
        return _width = width;
    }
    
    private function set_height(height:Float):Float 
    {
        return _height = height;
    }
}