package org.gestouch.examples.containers
{
	import spark.layouts.VerticalLayout;
	import spark.components.Group;


	/**
	 * @author Pavel fljot
	 */
	public class SettingsPanel extends Group
	{
		public function SettingsPanel()
		{
			super();
			
			var layout:VerticalLayout = new VerticalLayout();
			layout.paddingTop = 10;
			layout.paddingBottom = 10;
			layout.paddingLeft = 10;
			layout.paddingRight = 10;
			this.layout = layout;
			
			opaqueBackground = 0xEFEFEF;
		}
	}
}