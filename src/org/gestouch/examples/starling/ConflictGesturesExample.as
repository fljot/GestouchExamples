package org.gestouch.examples.starling
{
	import com.greensock.easing.Linear;
	import com.greensock.TweenLite;
	import starling.core.Starling;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;

	import com.greensock.TweenMax;

	import org.gestouch.core.GestureState;
	import org.gestouch.core.IGestureDelegate;
	import org.gestouch.core.Touch;
	import org.gestouch.events.LongPressGestureEvent;
	import org.gestouch.events.TapGestureEvent;
	import org.gestouch.events.TransformGestureEvent;
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
			freeTransform.addEventListener(TransformGestureEvent.GESTURE_TRANSFORM, onTransform, false, 0, true);
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
			longPress.addEventListener(LongPressGestureEvent.GESTURE_LONG_PRESS, onLongPress);
		}


		private function onLongPress(event:LongPressGestureEvent):void
		{
			if (event.gestureState != GestureState.BEGAN)
				return;
			
			const circle:Shape = new Shape();
			var g:Graphics = circle.graphics;
			g.beginFill(0x66ccff, 1);
			g.drawCircle(0, 0, 100);
			g.endFill();
			Starling.current.nativeStage.addChild(circle);
			circle.x = event.stageX;
			circle.y = event.stageY;
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
			tap.addEventListener(TapGestureEvent.GESTURE_TAP, onTap, false, 0, true);

			var freeTransform:TransformGesture = new TransformGesture(image);
			freeTransform.addEventListener(TransformGestureEvent.GESTURE_TRANSFORM, onTransform, false, 0, true);
			freeTransform.delegate = this;
			
			return image;
		}
		

		private function onTransform(event:TransformGestureEvent):void
		{
			var target:DisplayObject = (event.target as Gesture).target as DisplayObject;
			if (target == stage)
			{
				target = container;
				
				if (event.gestureState == GestureState.BEGAN)
				{
					containerIsTransforming = true;
				}
				else if (event.gestureState == GestureState.ENDED || event.gestureState == GestureState.CANCELLED)
				{
					containerIsTransforming = false;
				}
			}
			else
			{
				if (event.gestureState == GestureState.BEGAN)
				{
					innerActiveTransformGesturesCounter++;
				}
				else if (event.gestureState == GestureState.ENDED || event.gestureState == GestureState.CANCELLED)
				{
					innerActiveTransformGesturesCounter--;
				}
				
				// Recalculate offsets in case some parent is transformed
				if (event.offsetX != 0 || event.offsetY != 0)
				{
					var offset:Point = target.parent.globalToLocal(new Point(event.offsetX, event.offsetY)).subtract(target.parent.globalToLocal(GestureUtils.GLOBAL_ZERO));
					event.offsetX = offset.x;
					event.offsetY = offset.y;
				}
			}
			
			// Panning
			target.x += event.offsetX;
			target.y += event.offsetY;
			
			if (event.scaleX != 1 || event.rotation != 0)
			{
				var m:Matrix = target.getTransformationMatrix(target.parent);
				
				// Scale and rotation.
				// NB! event.localX and event.stageX actually represent previous
				// location of the centroid (middle point between two fingers so you
				// can easely perform these transformations without any additional transformations.
				var transformPoint:Point = m.transformPoint(new Point(event.localX, event.localY));
				m.translate(-transformPoint.x, -transformPoint.y);
				m.rotate(event.rotation * GestureUtils.DEGREES_TO_RADIANS);
				m.scale(event.scaleX, event.scaleY);
				m.translate(transformPoint.x, transformPoint.y);
				
				target.x = m.tx;
				target.y = m.ty;
				target.rotation = Math.atan2(m.b, m.a);
				target.scaleX = target.scaleY = Math.sqrt(m.a*m.a + m.b*m.b);
			}
		}


		private function onTap(event:TapGestureEvent):void
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