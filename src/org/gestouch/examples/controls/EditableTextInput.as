package org.gestouch.examples.controls
{
	import flash.events.KeyboardEvent;
	import spark.components.TextInput;


	/**
	 * @author Pavel fljot
	 */
	public class EditableTextInput extends TextInput
	{
		public function EditableTextInput()
		{
			super();			
		}
		
		
		override protected function keyDownHandler(event:KeyboardEvent):void
		{
			super.keyDownHandler(event);
			
			// if the key is ENTER
			if (event.charCode == 13)
			{
				editable = false;
			}
		}
	}
}
