package org.gestouch.examples.views
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.events.ResizeEvent;

	import org.gestouch.core.Gestouch;
	import org.gestouch.examples.starling.StarlingExampleBase;
	import org.gestouch.extensions.starling.StarlingDisplayListAdapter;
	import org.gestouch.extensions.starling.StarlingTouchHitTester;
	import org.gestouch.input.NativeInputAdapter;


	/**
	 * @author Pavel fljot
	 */
	public class StarlingExampleViewBase extends ExampleViewBase
	{
		protected var starling:Starling;
		private var starlingTouchHitTester:StarlingTouchHitTester;
		
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
            
			Gestouch.addDisplayListAdapter(starling.display.DisplayObject, new StarlingDisplayListAdapter());
		}
		
			
		override protected function init():void
		{
			super.init();
			
			var starlingMainClass:Class = data.starlingMainClass as Class;
			
			starling = new Starling(starlingMainClass, stage);
			starling.enableErrorChecking = true;
			starling.stage.color = 0xEFEFEF;
//			starling.stage.addEventListener(ResizeEvent.RESIZE, starling_resizeHandler);
			starling.stage.addEventListener("quit", quitHandler);
			starling.start();
			
			// Initialized native (default) input adapter. Needed for non-DisplayList usage.
			Gestouch.inputAdapter ||= new NativeInputAdapter(stage);
			
			starlingTouchHitTester = new StarlingTouchHitTester(starling);
			Gestouch.addTouchHitTester(starlingTouchHitTester, -1);
			
			root.visible = false;
		}


		private function quitHandler(...args):void
		{
			navigator.popView();
		}
		
		
		override protected function onViewDeactivate():void
		{
			super.onViewDeactivate();
			
			if (starlingTouchHitTester)
			{
				Gestouch.removeTouchHitTester(starlingTouchHitTester);
				starlingTouchHitTester = null;
			}
			
			starling.stage.removeEventListener(ResizeEvent.RESIZE, starling_resizeHandler);
			starling.stage.removeEventListener("quit", quitHandler);
			
			starling.dispose();
			starling = null;
			
			root.visible = true;
		}
		
		
		private function starling_resizeHandler(event:ResizeEvent):void
		{
			(starling.stage.getChildAt(0) as StarlingExampleBase).resize(event.width, event.height);
		}
	}
}