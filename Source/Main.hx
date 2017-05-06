package;
import com.RectTransform;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.StageDisplayState;
import openfl.events.Event;

class Main extends Sprite {
    var rect:Rectangle = new Rectangle();
    
	public function new () {
		super ();
        addChild(rect);
        Lib.current.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
        addEventListener(Event.ENTER_FRAME, gameLoop);
	}
    
    private function gameLoop(e:Event):Void 
    {
        RectTransform.windowHeight = stage.stageHeight;
        RectTransform.windowWidth  = stage.stageWidth;
        
        rect.doAction();
    }
}