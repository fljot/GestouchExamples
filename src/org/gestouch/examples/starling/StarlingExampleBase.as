package org.gestouch.examples.starling
{
	import fr.kouma.starling.utils.Stats;

	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	import flash.utils.setTimeout;


	/**
	 * @author Pavel fljot
	 */
	public class StarlingExampleBase extends Sprite
	{
		[Embed(source="/assets/images/back-button.png")]
		private static const backButtonImage:Class;
		
		private var backButton:Image;
		private var stats:Stats;
		
		
		public function StarlingExampleBase()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		
		protected function onResize(width:Number, height:Number):void
		{
			if (stats)
			{
				stats.x = width - stats.width;
			}
		}


		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		
		protected function init():void
		{
			stage.addEventListener(ResizeEvent.RESIZE, stage_resizeHandler);
			
			backButton = new Image(Texture.fromBitmap(new backButtonImage()));
			backButton.x = backButton.y = 3;
			backButton.scaleX = backButton.scaleY = 2;
			backButton.addEventListener(TouchEvent.TOUCH, backButton_touchHandler);
			addChild(backButton);
			
//			stats = new Stats();
//			addChild(stats);
			
			setTimeout(stage_resizeHandler, 1);
		}


		private function stage_resizeHandler(event:ResizeEvent = null):void
		{
			if (event)
			{
				onResize(event.width, event.height);
			}
			else if (stage)
			{
				onResize(stage.stageWidth, stage.stageHeight);
			}
		}


		private function backButton_touchHandler(event:TouchEvent):void
		{
			var touch:Touch = event.touches[0] as Touch;
			if (touch.phase == TouchPhase.ENDED)
			{
				stage.dispatchEvent(new Event("quit"));
			}
		}
	}
}