package org.gestouch.examples.base
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;


	/**
	 * @author Pavel fljot
	 */
	[SWF(backgroundColor="#FFFFFF", frameRate="40", width="800", height="600")]
	public class ExampleBase extends Sprite
	{		
		
		public function ExampleBase()
		{
			super();
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStageHandler);
		}


		private function addedToStageHandler(event:Event):void
		{
			init();
			postinit();
		}


		protected function init():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			stage.addEventListener(Event.RESIZE, stage_resizeHandler);
		}


		protected function postinit():void
		{
			stage_resizeHandler();
		}


		protected function onResize(sW:Number, sH:Number):void
		{
			
		}


		private function stage_resizeHandler(event:Event = null):void
		{
			onResize(stage.stageWidth, stage.stageHeight);
		}
	}
}