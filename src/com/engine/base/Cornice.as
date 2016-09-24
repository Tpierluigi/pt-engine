package com.engine.base 
{
	import spark.components.BorderContainer;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Cornice extends BorderContainer implements IContenitore 
	{
		
		public function Cornice() 
		{
			super();
			
		}
		
		
		/* INTERFACE com.engine.base.IContenitore */
		
		public function aggiungiForma(forma:IForma):void 
		{
			
		}
		
		public function rimuoviFormadaDisplayList(forma:IForma):void 
		{
			
		}
		
		public function get datiForma():DatiForma 
		{
			return _datiForma;
		}
		
		public function get listaProprieta():Array
		{
			return ["x", "y", "width", "height"];
		}
		public function get listaAzioni():Array{
			return [
				{f:"nuovoRettangolo", c:"Nuovo rettangolo"},
				{f:"nuovaImmagine", c:"Nuova immagine"},
				{f:"cancella", c:"cancella"}
				]
		}
		
		public function get defaultHandlers():FormaHandlers 
		{
			return new ContenitoreHandlers();
		}
		
		public function rimuoviDaDisplayList():void 
		{
			
		}
		
	}

}