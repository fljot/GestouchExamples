package org.gestouch.examples.model
{
	import org.gestouch.examples.views.HoldAndDragView;
	import org.gestouch.examples.views.DoubleTapGestureView;
	import org.gestouch.examples.views.DragGestureView;
	import org.gestouch.examples.views.FreeTransformView;
	import org.gestouch.examples.views.LongPressGestureView;
	import org.gestouch.examples.views.SwipeGestureView;

	import mx.collections.ArrayCollection;

	/**
	 * @author Pavel fljot
	 */
	public class ExamplesModel
	{
		public static const LONG_PRESS_GESTURE_HELP:String = (<text>LongPressGesture tracks the long press.
It has two phases: GesturePhase.BEGIN when timer is complete (finger is still down) and GesturePhase.END when user release the finger.
You can customize:
"slop" — the distance user should not overcome in case of (accidental) drag,
"timeThreshold" — time in ms that nescessary to detect gesture.
</text>).toString();
		
		
		[Bindable]
		public var examplesList:ArrayCollection = new ArrayCollection(
			[
				{label: "LongPressGesture Example", viewClass: LongPressGestureView},
				{label: "DoubleTapGesture Example", viewClass: DoubleTapGestureView},
				{label: "DragGesture Example", viewClass: DragGestureView},
				{label: "SwipeGesture Example", viewClass: SwipeGestureView},
				{label: "Free-transform Examples (Drag, Zoom, Rotate)", viewClass: FreeTransformView},
				{label: "Hold-n-Drag Example", viewClass: HoldAndDragView}
			]
		);
	}
}