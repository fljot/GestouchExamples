package org.gestouch.examples.controls
{
	import spark.components.TextArea;


	/**
	 * @author Pavel fljot
	 */
	public class HintText extends TextArea
	{
		public function HintText()
		{
			setStyle("contentBackgroundAlpha", 0);
			setStyle("borderVisible", false);
			alpha = 0.5;
			percentWidth = 100;
			enabled = false;
		}
	}
}