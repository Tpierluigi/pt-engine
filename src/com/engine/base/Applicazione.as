package com.engine.base
{
	import mx.core.IVisualElementContainer;
	import spark.components.Group;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Applicazione extends Forma
	{

		
		public function Applicazione(id:String, lista:Group)
		{
			super(id,null);
			_propertySet = <applicazione/>;
			_propertySet.@id = id;
			_elementi = lista;
			_elementi.invalidateDisplayList();
		}
		
		public function addElement(forma:Forma):void
		{
			_elementi.addElement(forma._elementi);
			this.propertySet.appendChild(forma.propertySet);
		}
	}

}