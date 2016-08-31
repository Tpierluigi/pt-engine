package com.engine.base 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author pier
	 */
	public class FormaEvent extends Event 
	{
		public static const CAMBIA_DIMENSIONI:String = "cambiaDimensioni";
		public var datiVari:Object;
		public function FormaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,datiVari:Object=null) 
		{ 
			super(type, bubbles, cancelable);
			this.datiVari = datiVari;
		} 
		
		public override function clone():Event 
		{ 
			return new FormaEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("FormaEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}