package org.gestouch.examples.views
{
	import flash.geom.Rectangle;
	import org.gestouch.core.GesturesManager;
	import org.gestouch.core.IGesturesManager;
	import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
	import org.gestouch.extensions.starling.StarlingInputAdapter;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.ResizeEvent;




	/**
	 * @author Pavel fljot
	 */
	public class StarlingExampleViewBase extends ExampleViewBase
	{
		protected var starling:Starling;
		protected var starlingMainClass:Class;
		private var starlingInputAdapter:StarlingInputAdapter;
		
		{
			initStarlingAndGestouchForStarling();
		}
		
		
		public function StarlingExampleViewBase()
		{
			super();
		}
		
		
		private static function initStarlingAndGestouchForStarling():void
		{
			Starling.multitouchEnabled = true; // useful on mobile devices
            Starling.handleLostContext = true; // deactivate on mobile devices (to save memory)
            
			var gesturesManager:IGesturesManager = GesturesManager.getInstance();
			gesturesManager.addDisplayListAdapter(starling.display.DisplayObject, new StarlingDisplayListAdapter());
		}
		
			
		override protected function init():void
		{
			super.init();
			
			starling = new Starling(starlingMainClass, stage);
			starling.enableErrorChecking = false;
			starling.stage.addEventListener(ResizeEvent.RESIZE, starling_resizeHandler);
			starling.stage.addEventListener("quit", quitHandler);
			starling.start();
			
			starlingInputAdapter = new StarlingInputAdapter(starling);
			var gesturesManager:IGesturesManager = GesturesManager.getInstance();
			gesturesManager.addInputAdapter(starlingInputAdapter);
			
			root.visible = false;
		}


		private function quitHandler(...args):void
		{
			navigator.popView();
		}
		
		
		override protected function onViewDeactivate():void
		{
			super.onViewDeactivate();
			
			var gesturesManager:IGesturesManager = GesturesManager.getInstance();
			gesturesManager.removeInputAdapter(starlingInputAdapter);
			starlingInputAdapter = null;
			
			starling.stage.removeEventListener(ResizeEvent.RESIZE, starling_resizeHandler);
			starling.stage.removeEventListener("quit", quitHandler);
			
			starling.dispose();
			starling = null;
			
			root.visible = true;
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