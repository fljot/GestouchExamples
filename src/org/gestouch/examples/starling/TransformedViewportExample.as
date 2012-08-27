package org.gestouch.examples.starling
{
	import starling.core.Starling;
	import starling.display.Image;
	import starling.textures.Texture;

	import com.greensock.TweenMax;

	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.Gesture;
	import org.gestouch.gestures.TapGesture;

	import flash.geom.Rectangle;


	/**
	 * @author Pavel fljot
	 */
	public class TransformedViewportExample extends StarlingExampleBase
	{
		[Embed(source="/assets/images/YellowSquare.png")]
		private static const yellowAsset:Class;
		
		
		public function TransformedViewportExample()
		{
			super();
		}
		
			
		override public function resize(width:int, height:int):void
		{
			const rect:Rectangle = new Rectangle(100, 100, width - 200, height - 200);
			const starling:Starling = Starling.current;
			starling.viewPort = rect;
			starling.stage.stageWidth = rect.width;
			starling.stage.stageHeight = rect.height;
			
			onResize(starling.stage.stageWidth, starling.stage.stageHeight);
		}
		
		
		override protected function init():void
		{
			super.init();
			
			var image:Image = new Image(Texture.fromBitmap(new yellowAsset()));
			//image.width = image.height = Math.min(stage.stageWidth, stage.stageHeight) / 3;
			image.y = 50;
			addChild(image);
			
			var tap:TapGesture = new TapGesture(image);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTap, false, 0, true);
		}
		

		private function onTap(event:GestureEvent):void
		{
			trace("tap");
			TweenMax.to((event.target as Gesture).target, 0.5, {bezierThrough:[{alpha:0.1}, {alpha:1}]});
		}
	}
}