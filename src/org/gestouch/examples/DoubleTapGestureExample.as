package org.gestouch.examples
{
	import com.bit101.components.HBox;
	import com.bit101.components.PushButton;
	import com.bit101.components.Style;
	import com.bit101.components.VBox;
	import com.bit101.components.Window;

	import org.gestouch.events.DoubleTapGestureEvent;
	import org.gestouch.examples.base.ExampleBase;
	import org.gestouch.examples.controls.EditableLabel;
	import org.gestouch.gestures.DoubleTapGesture;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.events.FocusEvent;


	/**
	 * @author Pavel fljot
	 */
	public class DoubleTapGestureExample extends ExampleBase
	{
		public function DoubleTapGestureExample()
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
			panel = new Window(vBox, 0, 0, "Double tap on the buttons so they would change their styles.");
			panel.draggable = false;
			var hBox:HBox = new HBox(panel);
			hBox.scaleX = hBox.scaleY = 2;
			var button:PushButton;
			button = new PushButton(hBox, 0, 0, "Double-tap me");
			DoubleTapGesture.add(button);
			button.addEventListener(DoubleTapGestureEvent.GESTURE_DOUBLE_TAP, button_gestureDoubleTapHandler);
			button = new PushButton(hBox, 0, 0, "Double-tap me");
			DoubleTapGesture.add(button);
			button.addEventListener(DoubleTapGestureEvent.GESTURE_DOUBLE_TAP, button_gestureDoubleTapHandler);
			
			panel = new Window(vBox, 0, 0, "Double tap on the label below to make it editable. Time threshold for gesture is set to 1000 ms.");
			panel.draggable = false;
			var label:EditableLabel = new EditableLabel(panel, 0, 0, "Double-tap me");
			label.scaleX = label.scaleY = 2;
			DoubleTapGesture.add(label, {timeThreshold: 1000});
			label.addEventListener(DoubleTapGestureEvent.GESTURE_DOUBLE_TAP, label_gestureDoubleTapHandler);
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
		
		
		private function button_gestureDoubleTapHandler(event:DoubleTapGestureEvent):void
		{
			var button:PushButton = event.currentTarget as PushButton;
			
			Style.BUTTON_FACE = 0xDDDDDD * Math.random();
			button.draw();
		}
		
		
		private function label_gestureDoubleTapHandler(event:DoubleTapGestureEvent):void
		{
			var label:EditableLabel = event.currentTarget as EditableLabel;
			label.editable = !label.editable;
			if (label.editable)
			{
				label.text = "You can edit me now...";
				label.addEventListener(FocusEvent.FOCUS_OUT, label_focusOutHandler);
			}
			else
			{
				label.text = "Double-tap me to make editable";
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