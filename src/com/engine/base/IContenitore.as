package com.engine.base 
{
	import spark.components.Group;
	
	/**
	 * ...
	 * @author pier
	 */
	public interface IContenitore extends IForma
	{
		/**
		 * aggiunge la forma specificata a questo contenitore
		 * @param	forma da aggiungere
		 */
		function aggiungiForma(forma:IForma):void;
		/**
		 * toglie la forma specificata da questo contenitore
		 * @param	forma da togliere
		 */
		function rimuoviFormadaDisplayList(forma:IForma):void; 
	}
	
}