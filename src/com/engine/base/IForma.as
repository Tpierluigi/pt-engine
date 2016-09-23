package com.engine.base 
{
	import flash.display.IDrawCommand;
	import mx.core.IUIComponent;
	
	/**
	 * ...
	 * @author pier
	 */
	public interface IForma extends IUIComponent
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
		function get defaultHandlers():FormaHandlers;
	}
	
}