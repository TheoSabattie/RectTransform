package;
import com.RectSize;
import com.RectTransform;
import com.Vector2;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.StageDisplayState;
import openfl.events.Event;
import yaml.Parser;
import yaml.Yaml;

class Main extends Sprite {    
    
    var parentRect:Rectangle = new Rectangle();
    var childRect:Rectangle = new Rectangle();
    
    public function new () {
        super ();
        
        addChild(parentRect);
        parentRect.addChild(childRect);
        Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        Lib.current.stage.addEventListener(Event.RESIZE, onResize);
        
        childRect.color = 0x000;
        
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
        
        var parentRectTransform:RectTransform = parentRect.rectTransform;
        var childRectTransform:RectTransform = childRect.rectTransform;
        
        parentRectTransform
            .setSizeDelta(new RectSize(0, 80))
            .setAnchorMin(new Vector2(0, 1))
            .setAnchorMax(new Vector2(1, 1))
            .setAnchoredPosition(new Vector2(0, 0))
            .setPivot(new Vector2(0.5, 1));
            
        childRectTransform.parent = parentRectTransform;
        childRectTransform
            .setAnchorMin(new Vector2(0.5, 0))
            .setAnchoredPosition(new Vector2(0, 0))
            .setPivot(new Vector2(0, 0.5));
    }
    
    private function onResize(e:Event):Void 
    {
        RectTransform.setWindowSize(RectTransform.getWindowSize().setWidthHeight(stage.stageWidth, stage.stageHeight));
        trace(childRect.rectTransform.toObject());
    }
}