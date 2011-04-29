package org.gestouch.examples
{
	import com.bit101.components.HUISlider;
	import com.bit101.components.VBox;
	import com.greensock.TweenMax;
	import com.greensock.easing.Sine;

	import org.gestouch.Direction;
	import org.gestouch.GestureUtils;
	import org.gestouch.events.SwipeGestureEvent;
	import org.gestouch.examples.base.ExampleBase;
	import org.gestouch.examples.controls.ArrowShape;
	import org.gestouch.gestures.SwipeGesture;

	import flash.display.BlendMode;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;




	/**
	 * @author Pavel fljot
	 */
	public class SwipeGestureExample extends ExampleBase
	{
		private var arrow:DisplayObject;
		private var swipeGesture:SwipeGesture;
		
		
		public function SwipeGestureExample()
		{
			super();
		}


		override protected function init():void
		{
			super.init();
			
			arrow = new ArrowShape();
			arrow.scaleX = arrow.scaleY = 50;
			arrow.blendMode = BlendMode.INVERT;
			arrow.alpha = 0;
			addChild(arrow);

			swipeGesture = SwipeGesture.add(stage, {direction: Direction.STRAIGHT_AXES});
			stage.addEventListener(SwipeGestureEvent.GESTURE_SWIPE, stage_gestureSwipeHandler);
			
			var box:VBox = new VBox(this, 10, 10);
			box.scaleX = box.scaleY = 4;
			var velocityThresholdSlider:HUISlider = new HUISlider(box, 0, 0, "velocityThreshold", function():void{
				swipeGesture.velocityThreshold = velocityThresholdSlider.value * GestureUtils.IPS_TO_PPMS;
			});
			velocityThresholdSlider.setSliderParams(1, 10, swipeGesture.velocityThreshold / GestureUtils.IPS_TO_PPMS);
			velocityThresholdSlider.tick = 0.5;
			velocityThresholdSlider.labelPrecision = 1;
		}


		override protected function onResize(sW:Number, sH:Number):void
		{
			super.onResize(sW, sH);
			
			arrow.x = sW >> 1;
			arrow.y = sH >> 1;
			return;
			var container:DisplayObjectContainer = getChildAt(0) as DisplayObjectContainer;
			var n:uint = container.numChildren;
			var child:DisplayObject;
			while (n-- > 0)
			{
				child = container.getChildAt(n);
				child.width = sW - container.x * 2;
			}
		}


		private function stage_gestureSwipeHandler(event:SwipeGestureEvent):void
		{
			arrow.scaleX = (event.offsetX < 0 && event.offsetY == 0 ? -1 : 1) * Math.abs(arrow.scaleX);
			var angle:int = 0;//event.offsetX == 0 ? (event.offsetY > 0 ? 90 : -90) : Math.atan(event.offsetY / event.offsetX) * 180 / Math.PI;
			if (event.offsetY != 0)
			{
				angle = event.offsetY > 0 ? 90 : -90;
			}
			arrow.rotation = angle;
			TweenMax.fromTo(arrow, 2, {alpha: 1}, {alpha: 0, ease: Sine.easeIn});
		}
	}
}