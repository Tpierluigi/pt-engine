package com.engine.base 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author pier
	 */
	public class FormaEvent extends Event 
	{
		public static const REFRESH_CP:String = "refreshCp";				//aggiornamento pannello di ispezione proprieta
		public static const REFRESH_RESIZER:String = "refreshResizer";		//lanciato quando di aggancia il resizer ad una nuova forma
		public static const CLICCATO:String = "cliccato";					//lanciato quando una forma viene cliccata
		public static const SELEZIONATO:String = "selezionato";				//lanciato quando il pannello di ispezione proprietà viene associato ad un oggetto
		public static const UPDATE_ASSETS:String = "updateAssets";			//lanciato quando un'immagine aggiorna la propria proprietà SOURCE
		public static const DESIGN:String = "design";
		public static const RUNTIME:String = "runtime";
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