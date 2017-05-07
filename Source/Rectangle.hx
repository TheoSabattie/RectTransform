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
    private var rectTransform:RectTransform = new RectTransform();
    
    public function new() 
    {
        super();
        
        var yaml:String = Assets.getText("assets/Panel.prefab");
        trace(yaml.substring(yaml.indexOf("RectTransform")));
        var rectDatas:Dynamic = Yaml.parse(yaml.substring(yaml.indexOf("RectTransform")), Parser.options().useObjects());
        rectDatas = rectDatas.RectTransform;
        
        //rectTransform.invertY = true;
        
        //rectTransform.sizeDelta.setWidthHeight(rectDatas.m_SizeDelta.x, rectDatas.m_SizeDelta.y);
        //rectTransform.anchorMin.setXY(rectDatas.m_AnchorMin.x, rectDatas.m_AnchorMin.y);
        //rectTransform.anchorMax.setXY(rectDatas.m_AnchorMax.x, rectDatas.m_AnchorMax.y);
        //rectTransform.anchoredPosition.setXY(rectDatas.m_AnchoredPosition.x, rectDatas.m_AnchoredPosition.y);
        //rectTransform.pivot.setXY(rectDatas.m_Pivot.x, rectDatas.m_Pivot.y);
        
        
        rectTransform.sizeDelta.setWidthHeight(50, 50);
        rectTransform.anchorMin.setXY(1, 1);
        rectTransform.anchorMax.setXY(1, 1);
        rectTransform.anchoredPosition.setXY(0, 0);
        rectTransform.pivot.setXY(1, 1);
    }
    
    public function doAction() {
        graphics.clear();
        graphics.beginFill(0xFF00F0);
        
        var rect:Rect = rectTransform.getRect();
        graphics.drawRect(rect.xMin, rect.yMin, rect.width, rect.height);
        graphics.endFill();
    }
}