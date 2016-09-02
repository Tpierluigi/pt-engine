package com.engine.base
{
	import spark.effects.supportClasses.ResizeInstance;
	
	/**
	 * ...
	 * @author pier
	 */
	internal class DatiForma
	{
		private var _padre:IForma;
		protected var _proprieta:XML;
		protected var _applicazione:Applicazione;
		
		public function DatiForma(padre:IForma=null)
		{
			_padre = padre;
			_proprieta = new XML();
			if (padre != null && padre is Applicazione) _applicazione = Applicazione(padre);
		}
		
		public function get padre():IForma 
		{
			return _padre;
		}
		
		public function set padre(value:IForma):void 
		{
			_padre = value;
		}
		public function get proprieta():XML{
			return _proprieta;
		}
		
		public function get applicazione():Applicazione 
		{
			return _applicazione;
		}
		
		public function leggiParametri(forma:IForma, parametri:Object):void
		{
			if (parametri != null)
			{
				for (var voce:String in parametri)
				{
					if (voce in forma)
					{
						forma[voce] = parametri[voce];
					}
				}
			}
		}
	
	}

}