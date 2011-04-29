package org.gestouch.examples.controls
{
	import com.bit101.components.Label;

	import flash.display.DisplayObjectContainer;
	import flash.events.KeyboardEvent;
	import flash.text.TextFieldType;


	/**
	 * @author Pavel fljot
	 */
	public class EditableLabel extends Label
	{
		public function EditableLabel(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number = 0, text:String = "")
		{
			super(parent, xpos, ypos, text);
		}
		
		
		/** @private */
		private var _editable:Boolean;
		
		/**
		 * 
		 */
		public function get editable():Boolean
		{
			return _editable;
		}
		public function set editable(value:Boolean):void
		{
			if (_editable == value) return;
			
			_editable = value;
			
			mouseChildren = _editable;
			
			invalidate();
		}
		
			
		override public function draw():void
		{
			super.draw();
			
			_tf.mouseEnabled = _tf.selectable = editable;
			if (editable)
			{				
				_tf.type = TextFieldType.INPUT;
				_tf.setSelection(0, _tf.length - 1);
				if (stage && (!stage.focus || stage.focus == this || this.contains(stage.focus)))
				{
					stage.focus = textField;
				}
			}
			else
			{
				_tf.type = TextFieldType.DYNAMIC;
				_tf.setSelection(0, 0);			
			}
		}
		
		
		override protected function init():void
		{
			super.init();
			
			_tf.addEventListener(KeyboardEvent.KEY_DOWN, textField_keyDownHandler);
			mouseEnabled = true;
		}


		private function textField_keyDownHandler(event:KeyboardEvent):void
		{
			// if the key is ENTER
			if (event.charCode == 13)
			{
				editable = false;
			}
		}
	}
}