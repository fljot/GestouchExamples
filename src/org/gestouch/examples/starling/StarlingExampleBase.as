package org.gestouch.examples.starling
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.ResizeEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.textures.Texture;

	import flash.geom.Rectangle;
	import flash.utils.setTimeout;


	/**
	 * @author Pavel fljot
	 */
	public class StarlingExampleBase extends Sprite
	{
		[Embed(source="/assets/images/back-button.png")]
		private static const backButtonImage:Class;
		
		private var backButton:Image;
		
		
		public function StarlingExampleBase()
		{
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}


		public function resize(width:int, height:int):void
		{
			const rect:Rectangle = new Rectangle(0, 0, width, height);
			const starling:Starling = Starling.current;
			starling.viewPort = rect;
			starling.stage.stageWidth = rect.width;
			starling.stage.stageHeight = rect.height;
			
			onResize(starling.stage.stageWidth, starling.stage.stageHeight);
		}
		
		
		protected function onResize(width:Number, height:Number):void
		{
			
		}


		private function onAddedToStage(event:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			
			init();
		}
		
		
		protected function init():void
		{			
			backButton = new Image(Texture.fromBitmap(new backButtonImage()));
			backButton.x = backButton.y = 3;
			backButton.scaleX = backButton.scaleY = 2;
			backButton.addEventListener(TouchEvent.TOUCH, backButton_touchHandler);
			addChild(backButton);
			
			setTimeout(resize, 1, stage.stageWidth, stage.stageHeight);
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