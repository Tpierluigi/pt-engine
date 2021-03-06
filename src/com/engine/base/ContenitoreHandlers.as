package com.engine.base
{
	import spark.events.ElementExistenceEvent;
	
	/**
	 * collezione di gestori evento (funzioni) comuni a tutte i contenitori
	 * pensata in maniera da riutilizzare gestori evento comuni tra di esse
	 * include quelli pensati per le forme
	 * di fatto è un singoletto (non ci sono campi), questo permette di poter usare nella forma una dichiarazione
	 * di interfaccia get per "simulare" una proprietà in sola lettura comune a tutte le forme.
	 * @author pier
	 */
	public final class ContenitoreHandlers extends FormaHandlers
	{
		
		public function ContenitoreHandlers()
		{
			super();
		}
		
		public function handlerAggiuntoOld(contenitore:IContenitore, e:ElementExistenceEvent):void
		{
			if (e.element != null && e.element is IForma){
				var f:IForma = e.element as IForma;
				f.forma.padre = contenitore;
			}
		}
		public function handlerAggiunto(contenitore:IContenitore, e:FormaEvent):void
		{
			if (e.datiVari.f != null && e.datiVari.f is IForma){
				var f:IForma = e.datiVari.f as IForma;
				f.forma.padre = contenitore;
			}
			e.stopImmediatePropagation();
		}
		public function handlerRimosso(contenitore:IContenitore, e:FormaEvent):void{
			if (e.datiVari.f != null && e.datiVari.f is IForma){
				var f:IForma = e.datiVari.f as IForma;
				f.forma.padre = null;
				f = null;
			}
		}
	}

}