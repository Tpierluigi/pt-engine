package com.engine.base 
{
	import mx.core.IVisualElementContainer;
	/**
	 * Raccoglie le proprietà e i metodi comuni a tutti i contenitori
	 * @author pier
	 */
	public class DatiContenitore extends DatiForma 
	{
		
		public function DatiContenitore(proprieta:XML, padre:IContenitore=null) 
		{
			super(proprieta, padre);
			
		}
		public function aggiungiForma(contenitore:IContenitore, forma:IForma):void{
			(contenitore as IVisualElementContainer).addElement(forma);
			contenitore.dispatchEvent(new FormaEvent(FormaEvent.FORMA_AGGIUNTA, true, false, {f:forma}));
		}
		public function rimuoviFormadaDisplayList(contenitore:IContenitore, forma:IForma):void{
			(contenitore as IVisualElementContainer).removeElement(forma);
			contenitore.dispatchEvent(new FormaEvent(FormaEvent.FORMA_RIMOSSA, true, false, {f:forma}));	
		}
	}

}