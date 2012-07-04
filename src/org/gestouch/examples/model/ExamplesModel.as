package org.gestouch.examples.model
{
	import org.gestouch.examples.starling.ConflictGesturesExample;
	import org.gestouch.examples.starling.TransformedViewportExample;
	import org.gestouch.examples.views.ConflictGesturesView;
	import org.gestouch.examples.views.DependentSwipingGesturesView;
	import org.gestouch.examples.views.DependentTapGesturesView;
	import org.gestouch.examples.views.LongPressGestureAdvancedView;
	import org.gestouch.examples.views.LongPressGestureView;
	import org.gestouch.examples.views.PanGestureView;
	import org.gestouch.examples.views.RotateGestureView;
	import org.gestouch.examples.views.StarlingExampleViewBase;
	import org.gestouch.examples.views.SwipeGestureView;
	import org.gestouch.examples.views.TapGestureUsageView;
	import org.gestouch.examples.views.TapGestureView;
	import org.gestouch.examples.views.TransformGestureView;
	import org.gestouch.examples.views.ZoomGestureView;

	import mx.collections.ArrayCollection;

	/**
	 * @author Pavel fljot
	 */
	public class ExamplesModel
	{		
		[Bindable]
		public var examplesList:ArrayCollection = new ArrayCollection(
			[
				{label: "TapGesture Basic Example", viewClass: TapGestureView}
				,{label: "TapGesture Usage Example", viewClass: TapGestureUsageView}
				,{label: "LongPressGesture Basic Example", viewClass: LongPressGestureView}
				,{label: "LongPressGesture Advanced Example", viewClass: LongPressGestureAdvancedView}
				,{label: "RotateGesture Basic Example", viewClass: RotateGestureView}
				,{label: "ZoomGesture Basic Example", viewClass: ZoomGestureView}
				,{label: "PanGesture Basic Example", viewClass: PanGestureView}
				,{label: "TransformGesture (Free Transform) Example", viewClass: TransformGestureView}
				,{label: "SwipeGesture Basic Example", viewClass: SwipeGestureView}
				,{label: "Conflicts Resolution Example", viewClass: ConflictGesturesView}
				,{label: "Dependent Tap Gestures Example", viewClass: DependentTapGesturesView}
				,{label: "Dependent Swiping Gestures Example", viewClass: DependentSwipingGesturesView}
				,{label: "Starling: Conflicts Example", viewClass: StarlingExampleViewBase, starlingMainClass: ConflictGesturesExample}
				,{label: "Starling: Transformed Viewport Example", viewClass: StarlingExampleViewBase, starlingMainClass: TransformedViewportExample}
			]
		);
	}
}