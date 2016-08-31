package com.engine.base 
{
	
	/**
	 * ...
	 * @author pier
	 */
	public interface IForma 
	{
		function get proprieta():XML;
		function set proprieta(val:XML):void;
		function get padre():IForma;
		function set padre(val:IForma):void;
		function get proprietaUsabili():Array;
		function _impostaGestoriDefault():void;
		function addElelement(forma:IForma):void;
	}
	
}