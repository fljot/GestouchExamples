package org.gestouch.examples.controls
{
	import flash.display.Graphics;
	import flash.display.Shape;


	/**
	 * @author Pavel fljot
	 */
	public class ArrowShape extends Shape
	{
		public function ArrowShape()
		{
			var g:Graphics = graphics;
			g.beginFill(0x000000);
			g.moveTo(-3, -1);
			g.lineTo(1, -1);
			g.lineTo(1, -2);
			g.lineTo(3, 0);
			g.lineTo(1, 2);
			g.lineTo(1, 1);
			g.lineTo(-3, 1);
			g.lineTo(-3, -1);
			g.endFill();
		}
	}
}
