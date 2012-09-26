package org.gestouch.examples.starling
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import org.gestouch.events.GestureEvent;
	import org.gestouch.gestures.symbolic.Symbol;
	import org.gestouch.gestures.symbolic.SymbolicGesture;
	import org.gestouch.gestures.symbolic.SymbolicGestureLevenstheinRecognizer;
	import org.gestouch.gestures.symbolic.sets.ActionsSymbolSet;
	
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	
	/**
	 * @author Aleksandr Kozlovskij (created: Sep 26, 2012)
	 */
	public class SymbolicGestureExample extends StarlingExampleBase
	{
		private var _starling:Starling;
		private var _container:Sprite;
		
		//------------ constructor ------------//
		
		public function SymbolicGestureExample()
		{
			super();
		}
		
		override protected function init():void
		{
			super.init();
			
			_container = new Sprite();
			addChild(_container);
			
			var symbolic:SymbolicGesture = new SymbolicGesture(stage, new SymbolicGestureLevenstheinRecognizer(10, 8));
			symbolic.addEventListener(GestureEvent.GESTURE_RECOGNIZED, symbolicGestureRecognizedHandler);
			
			//symbolic.addSymbolSet(new AlphabetSymbolSet());
			//symbolic.addSymbolSet(new NumericSymbolSet());
			symbolic.addSymbolSet(new ActionsSymbolSet(1));
			
			symbolic.addSymbol(new Symbol("<-", "4"));
			symbolic.addSymbol(new Symbol("->", "0"));
			
			symbolic.addSymbol(new Symbol("SPIRAL", "6543210765"));
		}
		
		//------- handlers / callbacks -------//
		
		private function symbolicGestureRecognizedHandler(e:GestureEvent):void
		{
			_container.removeChildren();
			
			var symbolic:SymbolicGesture = e.currentTarget as SymbolicGesture;
			
			trace('RECOGNIZED (', symbolic.bestMatch.fiability, ') : "' + symbolic.bestMatch.symbol.data + '"', '[' + symbolic.bestMatch.moves + ']', '=', '[' + symbolic.bestMatch.symbol.moves + ']');
			
			const bounds:Rectangle = symbolic.bestMatch.bounds;
			var q:Quad = new Quad(bounds.width, bounds.height, 0xFFFFFF);
			q.x = bounds.x;
			q.y = bounds.y;
			_container.addChild(q);
			
			
			const points:Vector.<Point> = symbolic.bestMatch.points.concat();
			for each(var p:Point in points)
			{
				q = new Quad(20, 20, 0xFFFFFF * Math.random());
				q.x = p.x;
				q.y = p.y;
				_container.addChild(q);
			}
		}
	}
}






import starling.display.Quad;
import starling.display.Sprite;
import starling.events.Event;



internal class SymbolicGestureExampleView extends Sprite
{
	public function SymbolicGestureExampleView()
	{
		super();
		
		addChild(new Quad(200, 200, 0xFF0000));
		
		addEventListener(Event.ADDED_TO_STAGE, initialize);
	}
	
	private function initialize(e:Event):void
	{
		removeEventListener(Event.ADDED_TO_STAGE, initialize);
		
		
	}
	
	
}
