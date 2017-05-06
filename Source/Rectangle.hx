package;
import com.Rect;
import com.RectTransform;
import openfl.display.Sprite;
import openfl.geom.Point;

/**
 * ...
 * @author Théo Sabattié
 */
class Rectangle extends Sprite
{
    private var rectTransform:RectTransform = new RectTransform();
    
    public function new() 
    {
        super();
        rectTransform.sizeDelta.SetWidthHeight(-50,-20);
    }
    
    public function doAction() {
        graphics.clear();
        graphics.beginFill(0x000000);
        
        var rect:Rect = rectTransform.getRect();
        graphics.drawRect(rect.xMin, rect.yMin, rect.width, rect.height);
        graphics.endFill();
    }
}