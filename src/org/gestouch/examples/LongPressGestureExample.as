package org.gestouch.examples
{
	import flash.events.GesturePhase;

	import com.bit101.components.HBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;

	import org.gestouch.events.LongPressGestureEvent;
	import org.gestouch.examples.base.ExampleBase;
	import org.gestouch.examples.controls.EditableLabel;
	import org.gestouch.gestures.LongPressGesture;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;


	/**
	 * @author Pavel fljot
	 */
	public class LongPressGestureExample extends ExampleBase
	{
		public function LongPressGestureExample()
		{
			super();
		}
		
		
		override protected function init():void
		{
			super.init();
			
//			scaleX = scaleY = 2;
			
			var vBox:VBox = new VBox(this, 10, 10);
			vBox.spacing = 10;
			
			var panel:Window;
			panel = new Window(vBox, 0, 0, "Hold buttons for a second so they would change their styles.");
			panel.draggable = false;
			var hBox:HBox = new HBox(panel);
			hBox.scaleX = hBox.scaleY = 2;
			var button:PushButton;
			button = new PushButton(hBox, 0, 0, "Hold me for a second");
			LongPressGesture.add(button);
			button.addEventListener(LongPressGestureEvent.GESTURE_LONG_PRESS, button_gestureHoldHandler);
			button = new PushButton(hBox, 0, 0, "Hold me for a second");
			LongPressGesture.add(button);
			button.addEventListener(LongPressGestureEvent.GESTURE_LONG_PRESS, button_gestureHoldHandler);
			
			
			panel = new Window(vBox, 0, 0, "Hold the labels below to make it editable. Time threshold for gesture is set to 1500 ms.");
			panel.height = 150;
			panel.draggable = false;
			var label:EditableLabel;
			vBox = new VBox(panel);
			vBox.spacing = 20;
			vBox.scaleX = vBox.scaleY = 2;
			label = new EditableLabel(vBox, 0, 0, "Hold me for some time");
			LongPressGesture.add(label, {timeThreshold: 1500});
			label.addEventListener(LongPressGestureEvent.GESTURE_LONG_PRESS, label_gestureHoldHandler);
			label.addEventListener(FocusEvent.FOCUS_OUT, label_focusOutHandler);
			
			label = new EditableLabel(vBox, 0, 0, "Hold me with two (2) fingers");
			LongPressGesture.add(label, {minTouchPointsCount: 2, maxTouchPointsCount: 2});
			label.addEventListener(LongPressGestureEvent.GESTURE_LONG_PRESS, label_gestureHoldHandler);
			label.addEventListener(FocusEvent.FOCUS_OUT, label_focusOutHandler);
		}
		
		
		override protected function onResize(sW:Number, sH:Number):void
		{
			super.onResize(sW, sH);
			
			var container:DisplayObjectContainer = getChildAt(0) as DisplayObjectContainer;
			var n:uint = container.numChildren;
			var child:DisplayObject;
			while (n-- > 0)
			{
				child = container.getChildAt(n);
				child.width = sW - container.x * 2;
			}
		}


		private function button_gestureHoldHandler(event:LongPressGestureEvent):void
		{
			var button:PushButton = event.currentTarget as PushButton;
			if (event.phase == GesturePhase.BEGIN)
			{
				button.label = "I was held for a second.. you can try again.";
				Style.BACKGROUND = 0xDDDDDD * Math.random();
			}
			else
			{
				Style.BUTTON_FACE = 0xDDDDDD * Math.random();
			}
			
			button.draw();
		}
		
		
		private function label_gestureHoldHandler(event:LongPressGestureEvent):void
		{
			var label:EditableLabel = event.currentTarget as EditableLabel;
			if (event.phase == GesturePhase.BEGIN)
			{
				label.editable = !label.editable;
				if (label.editable)
				{
					stage.focus = label.textField;
					label.text = "You can edit me now...";
				}
				else
				{
					label.text = "Hold me for to make editable";
				}
			}
		}


		private function label_focusOutHandler(event:FocusEvent):void
		{
			var label:EditableLabel = event.currentTarget as EditableLabel;
			if (stage.focus != label && (!stage.focus || !label.contains(stage.focus)))				
			{
				label.removeEventListener(FocusEvent.FOCUS_OUT, label_focusOutHandler);
				label.editable = false;
				label.text = "Double-tap me to make editable";
			}
		}
	}
}