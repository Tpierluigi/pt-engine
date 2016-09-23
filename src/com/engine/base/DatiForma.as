package com.engine.base
{
	import com.engine.applicazione.Applicazione;
	import spark.effects.supportClasses.ResizeInstance;
	
	/**
	 * ...
	 * @author pier
	 */
	public class DatiForma
	{
		private var _padre:IContenitore;
		protected var _proprieta:XML;
		protected var _applicazione:Applicazione;
		
		public function DatiForma(proprieta:XML, padre:IContenitore= null)
		{
			_padre = padre;
			_proprieta = proprieta;
			if (padre != null && padre is Applicazione) _applicazione = Applicazione(padre);
		}
		
		public function get padre():IContenitore
		{
			return _padre;
		}
		
		public function set padre(value:IContenitore):void
		{
			//devo staccare l'XML del padre se precedentemente inizializzato
			if (_padre != null)
			{
				delete padre.datiForma.proprieta.*.(@id == _proprieta.@id)[0]
			}
			if (value != null)
			{
				value.datiForma.proprieta.appendChild(this._proprieta);
			}
			_padre = value;
		
		}
		
		public function get proprieta():XML
		{
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
		public function eliminaFormaDaDisplayList(forma:IForma):void{
			var padre:IForma = forma.datiForma.padre;
			
		}
	
	}

}