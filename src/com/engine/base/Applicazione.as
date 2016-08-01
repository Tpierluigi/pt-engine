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
		var lista:Group;
		public function Applicazione(id:String,displayList:Group) 
		{
			super(id);
			lista = displayList;
		}
		public function addElement(forma:Forma){
			lista.addElement(forma._elementi);
			this.propertySet.appendChild(forma.propertySet);
		}
	}

}