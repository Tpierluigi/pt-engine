package com.engine.base 
{
	import mx.core.IUIComponent;
	
	/**
	 * ...
	 * @author pier
	 */
	public interface IForma extends IUIComponent
	{
		function get datiForma():DatiForma;
		/*
		function set x(val:Number):void;
		function set y(val:Number):void;
		function set height(val:Number):void;
		function set width(val:Number):void;

		function get x():Number;
		function get y():Number;
		function get height():Number;
		function get width():Number;
		*/
		function get listaProprieta():Array;
	}
	
}