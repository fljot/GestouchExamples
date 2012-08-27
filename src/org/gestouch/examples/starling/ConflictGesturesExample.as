package org.gestouch.examples.starling
{
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Linear;

	import org.gestouch.core.GestureState;
	import org.gestouch.core.IGestureDelegate;
	import org.gestouch.core.Touch;
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.Gesture;
	import org.gestouch.gestures.LongPressGesture;
	import org.gestouch.gestures.TapGesture;
	import org.gestouch.gestures.TransformGesture;
	import org.gestouch.utils.GestureUtils;

	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Point;


	/**
	 * @author Pavel fljot
	 */
	public class ConflictGesturesExample extends StarlingExampleBase implements IGestureDelegate
	{
		[Embed(source="/assets/images/YellowSquare.png")]
		private static const yellowAsset:Class;
		[Embed(source="/assets/images/CyanSquare.png")]
		private static const cyanAsset:Class;
		[Embed(source="/assets/images/MagentaSquare.png")]
		private static const magentaAsset:Class;
		
		private var container:Sprite;
		private var containerIsTransforming:Boolean;
		private var innerActiveTransformGesturesCounter:uint;
		
		
		public function ConflictGesturesExample()
		{
			super();
		}
		
		
		override protected function init():void
		{
			super.init();
			
			container = new Sprite();
			addChild(container);
			
			var freeTransform:TransformGesture = new TransformGesture(stage);
			freeTransform.addEventListener(GestureEvent.GESTURE_STATE_CHANGE, onTransform, false, 0, true);
			freeTransform.delegate = this;
			
			var image:Image;
			image = addImage(Texture.fromBitmap(new yellowAsset()));
			image.x = stage.stageWidth - 3 * image.width >> 1;
			image.y = stage.stageHeight - 3 * image.height >> 1;
			container.addChild(image);
			image = addImage(Texture.fromBitmap(new cyanAsset()));
			image.x = stage.stageWidth - image.width >> 1;
			image.y = stage.stageHeight - image.height >> 1;
			container.addChild(image);
			image = addImage(Texture.fromBitmap(new magentaAsset()));
			image.x = stage.stageWidth + image.width >> 1;
			image.y = stage.stageHeight + image.height >> 1;
			container.addChild(image);
			
			// native stage still acts as the parent of everything
			var longPress:LongPressGesture = new LongPressGesture(Starling.current.nativeStage);
			longPress.addEventListener(GestureEvent.GESTURE_STATE_CHANGE, onLongPress);
		}


		private function onLongPress(event:GestureEvent):void
		{
			const gesture:LongPressGesture = event.target as LongPressGesture;
			
			if (event.newState != GestureState.BEGAN)
				return;
			
			const circle:Shape = new Shape();
			var g:Graphics = circle.graphics;
			g.beginFill(0x66ccff, 1);
			g.drawCircle(0, 0, 100);
			g.endFill();
			Starling.current.nativeStage.addChild(circle);
			const location:Point = gesture.location;
			circle.x = location.x;
			circle.y = location.y;
			TweenLite.to(circle, 0.5, {
				alpha: 0,
				scaleX: 0,
				scaleY: 0,
				ease: Linear.easeNone,
				onComplete: circle.parent.removeChild,
				onCompleteParams: [circle]
			});
		}
		
		
		private function addImage(texture:Texture):Image
		{
			var image:Image = new Image(texture);
			image.width = image.height = Math.min(stage.stageWidth, stage.stageHeight) / 3;

			var tap:TapGesture = new TapGesture(image);
			tap.addEventListener(GestureEvent.GESTURE_RECOGNIZED, onTap, false, 0, true);

			var freeTransform:TransformGesture = new TransformGesture(image);
			freeTransform.addEventListener(GestureEvent.GESTURE_STATE_CHANGE, onTransform, false, 0, true);
			freeTransform.delegate = this;
			
			return image;
		}
		

		private function onTransform(event:GestureEvent):void
		{
			const gesture:TransformGesture = event.target as TransformGesture;
			var target:DisplayObject = gesture.target as DisplayObject;
			var offsetX:Number = gesture.offsetX;
			var offsetY:Number = gesture.offsetY;
			
			if (target == stage)
			{
				target = container;
				
				if (event.newState == GestureState.BEGAN)
				{
					containerIsTransforming = true;
				}
				else if (event.newState == GestureState.ENDED || event.newState == GestureState.CANCELLED)
				{
					containerIsTransforming = false;
				}
			}
			else
			{
				if (event.newState == GestureState.BEGAN)
				{
					innerActiveTransformGesturesCounter++;
				}
				else if (event.newState == GestureState.ENDED || event.newState == GestureState.CANCELLED)
				{
					innerActiveTransformGesturesCounter--;
				}
				
				// Recalculate offsets in case some parent is transformed
				var offset:Point = target.parent.globalToLocal(new Point(offsetX, offsetY)).subtract(target.parent.globalToLocal(GestureUtils.GLOBAL_ZERO));
				offsetX = offset.x;
				offsetY = offset.y;
			}
			
			// Panning
			target.x += offsetX;
			target.y += offsetY;
			
			if (gesture.scale != 1 || gesture.rotation != 0)
			{
				var m:Matrix = target.getTransformationMatrix(target.parent);
				
				// Scale and rotation.
				var transformPoint:Point = m.transformPoint(target.globalToLocal(gesture.location));
				m.translate(-transformPoint.x, -transformPoint.y);
				m.rotate(gesture.rotation);
				m.scale(gesture.scale, gesture.scale);
				m.translate(transformPoint.x, transformPoint.y);
				
				target.x = m.tx;
				target.y = m.ty;
				target.rotation = Math.atan2(m.b, m.a);
				target.scaleX = target.scaleY = Math.sqrt(m.a*m.a + m.b*m.b);
			}
		}


		private function onTap(event:GestureEvent):void
		{
			trace("tap");
			TweenMax.to((event.target as Gesture).target, 0.5, {bezierThrough:[{alpha:0.1}, {alpha:1}]});
		}


		public function gestureShouldReceiveTouch(gesture:Gesture, touch:Touch):Boolean
		{
			if (containerIsTransforming && gesture is TransformGesture && container.contains(gesture.target as DisplayObject))
			{
				// Let the inner transform gestures don't even receive touch
				// if container's transform gesture is in progress
				return false;
			}
			
			if (gesture is TransformGesture && gesture.target == stage && innerActiveTransformGesturesCounter > 0)
			{
				// One or more inner squares are currently transforming.
				// To prevent strange offsets we ignore this touch for our stage transform gesture
				return false;
			}
			
			// Default behavior
			return true;
		}


		public function gestureShouldBegin(gesture:Gesture):Boolean
		{
			// Default behavior
			return true;
		}


		public function gesturesShouldRecognizeSimultaneously(gesture:Gesture, otherGesture:Gesture):Boolean
		{
			// Default behavior
			return false;
		}
	}
}