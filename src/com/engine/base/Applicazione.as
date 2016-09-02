package com.engine.base
{
	import flash.events.MouseEvent;
	import mx.containers.Form;
	import mx.core.IVisualElementContainer;
	import spark.components.BorderContainer;
	import spark.components.Group;
	import mx.controls.Alert;
	import com.engine.util.Utility;
	/**
	 * ...
	 * @author pier
	 */
	[Bindable]
	public class Applicazione extends Group implements IContenitore
	{
		protected var _datiForma:DatiForma;
		
		protected var _designMode:Boolean;
		//public  static function nuovaIstanza(id:String, lista:BorderContainer, parametri:Object = null):Applicazione{
			//var istanza:Applicazione;
			//istanza = Applicazione(new Forma(id, null,null));
			////devo rinominare l'XML con i dati della proprieta
			//istanza._proprieta.setName("applicazione");
			//istanza._proprieta.@id = id;
			//istanza._elementi = lista;
			//istanza._leggiParametri(parametri);
			//istanza._impostaGestoriDefault();
			//return istanza;
		//}

		function Applicazione(id:String, parametri:Object = null)
		{
			super();
			_datiForma = new DatiForma();
			_datiForma.proprieta.setName("applicazione");
			_datiForma.proprieta.@id = id;
			_datiForma.leggiParametri(this, parametri);
		}
		
		protected function _impostaGestoriDefault():void
		{
			//TODO da definire i listener  di default
		}
		
		public function aggiungiElemento(forma:IForma):void
		{
			datiForma.proprieta.appendChild(forma.datiForma.proprieta);
			
		}
		
		public function get applicazione():Applicazione{
			return this;
		}
		
		public function get designMode():Boolean
		{
			return _designMode;
		}
		
		public function set designMode(value:Boolean):void
		{
			_designMode = value;
		}
		public function get padre():IForma{
			return null;
		}

		public function get proprietaUsabili(): Array{
			// TODO: da definire quali sono
			return [];
		}
		public function get proprieta():XML{
			return datiForma.proprieta;
		}
		
		public function get datiForma():DatiForma 
		{
			return _datiForma;
		}
	}

}