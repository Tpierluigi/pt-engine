package com.engine.base
{
	import flash.events.MouseEvent;
	import mx.events.PropertyChangeEvent;
	
	/**
	 * collezione di gestori evento (funzioni) comuni a tutte le forme
	 * pensata in maniera da riutilizzare gestori evento comuni tra di esse
	 * di fatto è un singoletto (non ci sono campi), questo permette di poter usare nella forma una dichiarazione
	 * di interfaccia get per "simulare" una proprietà in sola lettura comune a tutte le forme.
	 * @author pier
	 */
	public class FormaHandlers
	{
		public function FormaHandlers()
		{
		
		}
		
		public function clickHandler(forma:IForma, e:MouseEvent):void
		{
			forma.dispatchEvent(new FormaEvent(FormaEvent.CLICCATO, true));
			e.stopImmediatePropagation();
		}
		
		public function propChangeHandler(forma:IForma, e:PropertyChangeEvent):void
		{
			forma.forma.proprieta.@[e.property] = e.newValue;
			forma.dispatchEvent(new FormaEvent(FormaEvent.REFRESH_CP, true));
		}
	}

}