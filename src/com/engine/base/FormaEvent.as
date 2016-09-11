package com.engine.base 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author pier
	 */
	public class FormaEvent extends Event 
	{
		public static const REFRESH_CP:String = "refreshCp";
		public static const REFRESH_RESIZER:String = "refreshResizer";
		public static const CLICCATO:String = "cliccato";
		public static const SELEZIONATO:String = "selezionato";
	
		public var datiVari:Object;
		public function FormaEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false,datiVari:Object=null) 
		{ 
			super(type, bubbles, cancelable);
			this.datiVari = datiVari;
		} 
		
		public override function clone():Event 
		{ 
			var e:FormaEvent = new FormaEvent(type, bubbles, cancelable);		 
			e.datiVari = this.datiVari;
			return e;
		}
		
		public override function toString():String 
		{ 
			return formatToString("FormaEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}