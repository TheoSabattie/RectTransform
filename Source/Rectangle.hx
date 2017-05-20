package;
import com.Rect;
import com.RectTransform;
import openfl.Assets;
import openfl.display.Sprite;
import openfl.geom.Point;
import yaml.Parser;
import yaml.Yaml;

/**
 * ...
 * @author Théo Sabattié
 */
class Rectangle extends Sprite
{
    public var rectTransform(default, null):RectTransform = new RectTransform();
    public var color:Int = 0xFF00F0;
    
    public function new() 
    {
        super();
        rectTransform.onUpdatedListeners.push(onRectTransformUpdated);
    }
    
    public function onRectTransformUpdated(rectTransform:RectTransform):Void {
        graphics.clear();
        graphics.beginFill(color);
        
        var rect:Rect = rectTransform.getRect();
        graphics.drawRect(0, 0, rect.width, rect.height);
        graphics.endFill();
        x = rect.xMin;
        y = rect.yMin;
    }
}