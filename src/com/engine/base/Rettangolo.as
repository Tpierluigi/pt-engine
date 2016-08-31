package com.engine.base
{
	import mx.graphics.IFill;
	import mx.graphics.SolidColor;
	import spark.components.BorderContainer;
	import spark.components.Group;
	import spark.components.supportClasses.SkinnableComponent;
	import spark.primitives.Rect;
	import flash.events.MouseEvent;
	import mx.controls.Alert;
	import mx.events.FlexEvent;
	import mx.events.PropertyChangeEvent;
	/**
	 * ...
	 * @author pier
	 */
	public class Rettangolo extends BorderContainer implements IForma 
	{
		/*
		 * valori di default per il posizionamento dei nuovi oggetti
		 * */
		

		
		protected var _rettangolo:Rect;
		protected var _gruppo:Group;
		protected var datiForma:DatiForma;

		private var _alreadyInitialized:Boolean = false;
		protected var _hasFocus:Boolean;
		
		protected static var gestH1:Function;
		protected static var gestH2:Function;
		protected static var gestClick:Function;
		public  static function nuovaIstanza(id:String, padre:Forma = null,parametri:Object= null):Rettangolo{
			var istanza:Rettangolo = new Rettangolo(id, padre, parametri);
			return istanza;
		}
		public function Rettangolo(id:String, padre:IForma = null, opzioni:Object = null)
		{
			super();
			this.datiForma = new DatiForma(padre, null);
			//devo rinominare l'XML con i dati della proprieta
			this.datiForma.proprieta.setName("rettangolo");
			this._impostaGestoriDefault();
			this.id = id;
			//sovrascrivo con i parametri eventualmente passati..
			_leggiParametri(opzioni);
			
	
			//TODO: aggiungo il gruppo (che contiene il rettangolo) alla lista degli elementi
			//di cui è composto il componente
		}
	
		protected function _impostaGestoriDefault():void{
			super._impostaGestoriDefault();
			this.addEventListener("formaClick", function(e:FormaEvent):void{
				Alert.show("sono il formaevent del rettangolo!!");
			});
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent){
				datiForma.proprieta[e.property] = e.newValue;
			});
		}


	}

}

