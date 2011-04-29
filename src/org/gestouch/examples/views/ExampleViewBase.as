package org.gestouch.examples.views
{
	import spark.events.ViewNavigatorEvent;
	import flash.events.MouseEvent;
	import spark.components.Button;
	import spark.components.View;

	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;


	/**
	 * @author Pavel fljot
	 */
	public class ExampleViewBase extends View
	{
		private var backButton:Button;
		private var helpButton:Button;
		
		
		public function ExampleViewBase()
		{
			super();
			
			backButton = new Button();
			backButton.label = "Back";
			helpButton = new Button();
			helpButton.label = "?";
			
			navigationContent = [backButton];
			actionContent = [helpButton];
			addEventListener(ResizeEvent.RESIZE, resizeHandler);
			addEventListener(FlexEvent.INITIALIZE, initializeHandler);
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			addEventListener(ViewNavigatorEvent.VIEW_ACTIVATE, viewActivateHandler);
			addEventListener(ViewNavigatorEvent.VIEW_DEACTIVATE, viewDeactivateHandler);
		}
		
		
		protected function init():void
		{
			
		}
		
		
		protected function openHelp():void
		{
			
		}


		protected function onViewActivate():void
		{
			
		}
		
		
		protected function onViewDeactivate():void
		{
			
		}


		protected function onResize(width:Number, height:Number):void
		{
			
		}


		private function viewActivateHandler(event:ViewNavigatorEvent):void
		{
			backButton.addEventListener(MouseEvent.CLICK, backButton_clickHandler);
			helpButton.addEventListener(MouseEvent.CLICK, helpButton_clickHandler);
			
			onViewActivate();
		}


		private function helpButton_clickHandler(event:MouseEvent):void
		{
			openHelp();
		}


		private function viewDeactivateHandler(event:ViewNavigatorEvent):void
		{
			backButton.removeEventListener(MouseEvent.CLICK, backButton_clickHandler);
			helpButton.removeEventListener(MouseEvent.CLICK, helpButton_clickHandler);
			
			onViewDeactivate();
		}


		private function backButton_clickHandler(event:MouseEvent):void
		{
			backButton.removeEventListener(MouseEvent.CLICK, backButton_clickHandler);
			navigator.popView();
		}


		private function initializeHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.INITIALIZE, initializeHandler);
			init();
		}
		
		
		private function creationCompleteHandler(event:FlexEvent):void
		{
			removeEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			onResize(width, height);
		}


		private function resizeHandler(event:ResizeEvent):void
		{
			onResize(width, height);
		}
	}
}