package org.gestouch.examples.views
{
	import spark.components.Button;
	import spark.components.View;
	import spark.events.ViewNavigatorEvent;

	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.events.ResizeEvent;

	import flash.events.MouseEvent;
	import flash.system.Capabilities;


	/**
	 * @author Pavel fljot
	 */
	public class ExampleViewBase extends View
	{
		[Embed("/assets/images/settings-icon.png")]
		private static const settingsIconAsset:Class;
			
		private var backButton:Button;
		private var settingsButton:Button;
		
		
		public function ExampleViewBase()
		{
			super();
			
			settingsButton = new Button();
			settingsButton.setStyle("icon", settingsIconAsset);
			
			backButton = new Button();
			if (Capabilities.manufacturer.toLowerCase().indexOf("android") == -1)
			{
				backButton.label = "Back";
				navigationContent = [backButton];
			}
			if (this.hasOwnProperty("settings"))
			{
				actionContent = [settingsButton];
			}
			
			addEventListener(ResizeEvent.RESIZE, resizeHandler);
			addEventListener(FlexEvent.INITIALIZE, initializeHandler);
			addEventListener(FlexEvent.CREATION_COMPLETE, creationCompleteHandler);
			addEventListener(ViewNavigatorEvent.VIEW_ACTIVATE, viewActivateHandler);
			addEventListener(ViewNavigatorEvent.VIEW_DEACTIVATE, viewDeactivateHandler);
		}
		
		
		protected function get settingsPanel():UIComponent
		{
			return this["settings"] as UIComponent;
		}
		
		
		protected function init():void
		{
			
		}
		
		
		protected function openSettings():void
		{
			if (settingsPanel)
			{
				if (settingsPanel.stage)
				{
					removeElement(settingsPanel);
				}
				else
				{
					addElement(settingsPanel);
				}
			}
		}


		protected function onViewActivate():void
		{
			if (data)
			{				
				if (data.hasOwnProperty("title"))
				{
					title = data.title;
				}
			}
		}
		
		
		protected function onViewDeactivate():void
		{
			
		}
		
		
		protected function onResize(width:Number, height:Number):void
		{
			
		}
		
		
		private function viewActivateHandler(event:ViewNavigatorEvent):void
		{
			if (backButton)
			{
				backButton.addEventListener(MouseEvent.CLICK, backButton_clickHandler);
			}
			settingsButton.addEventListener(MouseEvent.CLICK, settingsButton_clickHandler);
			
			onViewActivate();
		}
		
		
		private function settingsButton_clickHandler(event:MouseEvent):void
		{
			openSettings();
		}
		
		
		private function viewDeactivateHandler(event:ViewNavigatorEvent):void
		{
			backButton.removeEventListener(MouseEvent.CLICK, backButton_clickHandler);
			settingsButton.removeEventListener(MouseEvent.CLICK, settingsButton_clickHandler);
			
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