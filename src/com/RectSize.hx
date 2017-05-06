package com;

/**
 * ...
 * @author Théo Sabattié
 */
class RectSize implements IRectSize
{
    public var onUpdatedListeners(default, null):Array<RectSize->Void> = [];
    
    private var _width:Float;
    private var _height:Float;
    
    public var width(get, set):Float;
    public var height(get, set):Float;
    
    public function new(width:Float = 0, height:Float = 0) 
    {
        _width = width;
        _height = height;
    }
    
    public function SetWidthHeight(width:Float, height:Float):RectSize {
        _width = width;
        _height = height;
        emitUpdated();
        
        return this;
    }
    
    private function emitUpdated():Void {
        for (i in 0...onUpdatedListeners.length) {
            onUpdatedListeners[i](this);
        }
    }
    
    private function get_width():Float 
    {
        return _width;
    }
    
    private function set_width(width:Float):Float 
    {
        _width = width;
        emitUpdated();
        
        return _width;
    }
    
    
    private function get_height():Float 
    {
        return _height;
    }
    
    private function set_height(height:Float):Float 
    {
        _height = height;
        emitUpdated();
        
        return _height;
    }
    
}