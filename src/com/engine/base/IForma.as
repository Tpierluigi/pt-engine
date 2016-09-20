package com.engine.base 
{
	import mx.core.IUIComponent;
	
	/**
	 * ...
	 * @author pier
	 */
	public interface IForma extends IUIComponent
	{
		/**
		 * ritorna l'oggetto con i dati e le caratteristiche della comuni alle varie forme
		 */
		function get datiForma():DatiForma;
		/**
		 * ritorna la lista delle proprietà modificabili dal pannello di controllo
		 */
		function get listaProprieta():Array;
		
		/**
		 * ritorna la lista delle azioni effettuabili dal pannello di controllo
		 * 
		 * */
		function get listaAzioni():Object;
	}
	
}