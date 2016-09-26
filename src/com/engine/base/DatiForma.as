package com.engine.base
{
	import com.engine.applicazione.Applicazione;
	import spark.effects.supportClasses.ResizeInstance;
	
	/**
	 * Raccoglie i metodi e le proprietà comuni a tutte le forme
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
		
		public function set padre(oggetto:IContenitore):void
		{
			//devo staccare l'XML del padre se precedentemente inizializzato
			if (_padre != null)
			{
				var valId:String = _proprieta.@id;
				for each (var figlio:XML in padre.forma.proprieta.*){
					if (figlio.@id == valId) {
						delete padre.forma.proprieta.*[figlio.childIndex()] as XML;
					}
				}
			}
			if (oggetto != null)
			{
				oggetto.forma.proprieta.appendChild(this._proprieta);
			}
			_padre = oggetto;
		
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

	}

}