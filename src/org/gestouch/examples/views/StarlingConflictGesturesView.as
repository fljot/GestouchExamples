package org.gestouch.examples.views
{
	import org.gestouch.examples.starling.ConflictGesturesExample;


	/**
	 * @author Pavel fljot
	 */
	public class StarlingConflictGesturesView extends StarlingExampleViewBase
	{
		public function StarlingConflictGesturesView()
		{
			super();
		}
		
		
		override protected function init():void
		{
			starlingMainClass = ConflictGesturesExample; 
			
			super.init();
		}
	}
}