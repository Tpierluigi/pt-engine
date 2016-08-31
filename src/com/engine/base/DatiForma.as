package com.engine.base
{
	
	/**
	 * ...
	 * @author pier
	 */
	internal class DatiForma
	{
		private var _proprietaUsabili;
		private var _padre:IForma;
		public var proprieta:XML;
		
		public function DatiForma(padre:IForma, proprietaUsabili:Array)
		{
			_padre = padre;
			proprieta = new XML();
			_proprietaUsabili = proprietaUsabili;
		}
		
		public function get proprietaUsabili():Array
		{
			return _proprietaUsabili;
		}
		
		public function get padre():IForma 
		{
			return _padre;
		}
		
		public function set padre(value:IForma):void 
		{
			_padre = value;
		}
		
		public function leggiParametri(oggetto:IForma, parametri:Object)
		{
			if (parametri != null)
			{
				for (var voce:String in parametri)
				{
					if (oggetto.hasOwnProperty(voce))
					{
						oggetto[voce] = parametri[voce];
					}
				}
			}
		}
	
	}

}