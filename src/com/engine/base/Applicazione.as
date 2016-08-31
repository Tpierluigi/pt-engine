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
	public class Applicazione extends Group implements IForma
	{
		protected var datiForma:DatiForma;
		
		protected var _designMode:Boolean;
		public  static function nuovaIstanza(id:String, lista:BorderContainer, parametri:Object = null):Applicazione{
			var istanza:Applicazione;
			istanza = Applicazione(new Forma(id, null,null));
			//devo rinominare l'XML con i dati della proprieta
			istanza._proprieta.setName("applicazione");
			istanza._proprieta.@id = id;
			istanza._elementi = lista;
			istanza._leggiParametri(parametri);
			istanza._impostaGestoriDefault();
			return istanza;
		}
		function Applicazione(id:String, parametri:Object = null)
		{
			super();
			proprieta = <applicazione/>
			proprieta.@id = id;
			datiForma.leggiParametri(this, parametri);
		}
		
		protected function _impostaGestoriDefault():void
		{
			super._impostaGestoriDefault();
			this.addEventListener("formaClick", function(e:FormaEvent):void
			{
				Alert.show("sono il formaevent dell'app!!");
			});
			
		}
		
		public function addElement(forma:IForma):void
		{
			proprieta.appendChild(forma.propertySet);
		}
		
		override public function set y(value:Number):void
		{
			_proprieta.@y = value;
			_elementi.y = value;
		}
		
		override public function set x(value:Number):void
		{
			_proprieta.@x = value;
			_elementi.x = value;
		
		}
		
		override public function set larghezza(value:Number):void
		{
			super.larghezza= value;
			_elementi.width = value;
		}
		
		override public function set altezza(value:Number):void
		{
			super.altezza= value;
			_elementi.height = value;
		
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
		public function set padre(v:IForma):void{
			
		}
		public function get proprietaUsabili(): Array{
			return datiForma.proprietaUsabili;
		}
		public function get proprieta():XML{
			return datiForma.proprieta;
		}
		public function set proprieta(val:XML){
			datiForma.proprieta = val;
		}
	}

}