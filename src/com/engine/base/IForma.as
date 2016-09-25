package com.engine.base 
{
	import flash.display.IDrawCommand;
	import mx.core.IUIComponent;
	import mx.core.IVisualElement;
	
	/**
	 * ...
	 * @author pier
	 */
	public interface IForma extends IVisualElement
	{
		function get id():String;
		function set id(val:String):void;
		
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
		function get listaAzioni():Array;
		/**
		 * ritorna la lista degli handler di default; è agganciato di solito ad un oggetto di una classe che contiene 
		 * i geestori evento comuni alle forme
		 * */
		function get defaultHandlers():FormaHandlers;
		/**
		 * rimuove la forma dalla display list dell'oggetto padre
		 */
		function rimuoviDaDisplayList():void;
		
	}
	
}