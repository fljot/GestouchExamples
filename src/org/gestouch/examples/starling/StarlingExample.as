package org.gestouch.examples.starling
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Rectangle;
	import org.gestouch.core.GesturesManager;
	import org.gestouch.core.IGesturesManager;
	import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
	import org.gestouch.extensions.starling.StarlingInputAdapter;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.ResizeEvent;



	[SWF(backgroundColor="#FFFFFF", frameRate="60", width="640", height="480")]
	/**
	 * @author Pavel fljot
	 */
	public class StarlingExample extends Sprite
	{
		private var starling:Starling;
		
		
		public function StarlingExample()
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.align = StageAlign.TOP_LEFT;
            
            Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
            
            starling = new Starling(StarlingRoot, stage);
            starling.enableErrorChecking = false;
			starling.stage.addEventListener(ResizeEvent.RESIZE, starling_resizeHandler);
            starling.start();
			
			var gesturesManager:IGesturesManager = GesturesManager.getInstance();
			gesturesManager.addDisplayListAdapter(starling.display.DisplayObject, new StarlingDisplayListAdapter());
			gesturesManager.addInputAdapter(new StarlingInputAdapter(starling));
		}


		private function starling_resizeHandler(event:ResizeEvent):void
		{
			var rect:Rectangle = new Rectangle(0, 0, event.width, event.height);
			starling.viewPort = rect;
			starling.stage.stageWidth = rect.width;
			starling.stage.stageHeight = rect.height;
		}
	}
}