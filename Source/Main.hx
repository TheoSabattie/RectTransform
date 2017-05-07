package;
import com.RectTransform;
import openfl.Assets;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.StageDisplayState;
import openfl.events.Event;
import yaml.Yaml;

class Main extends Sprite {
    private var testRectangle:Rectangle = new Rectangle();
    
    public function new () {
        super ();
        addChild(testRectangle);
        Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        addEventListener(Event.ENTER_FRAME, gameLoop);
    }
    
    private function gameLoop(e:Event):Void 
    {
        RectTransform.windowSize.setWidthHeight(stage.stageWidth, stage.stageHeight);
        testRectangle.doAction();
    }
}