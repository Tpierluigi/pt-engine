package com.engine.base
{
	import flash.events.Event;
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
		
		protected var _datiForma:DatiForma;

		public function Rettangolo(id:String, padre:IForma = null, opzioni:Object = null)
		{
			super();
			this._datiForma = new DatiForma(padre);
			//devo rinominare l'XML con i dati della proprieta
			this._datiForma.proprieta.setName("rettangolo");
			this._impostaGestoriDefault();
			this.id = id;
			//sovrascrivo con i parametri eventualmente passati..
			this._datiForma.leggiParametri(this,opzioni);
			if (padre != null ) {
				this._datiForma.padre = padre;
				padre.datiForma.proprieta.appendChild(datiForma.proprieta);
			}
	
			//TODO: aggiungo il gruppo (che contiene il rettangolo) alla lista degli elementi
			//di cui è composto il componente
		}
	
		protected function _impostaGestoriDefault():void{
			var $this:Rettangolo = this;
			$this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void{
				$this.dispatchEvent(new FormaEvent(FormaEvent.CLICCATO, true));
			});
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void{
				for (var i:int = 0; i < proprietaUsabili.length; i++) 
				{
					if (e.property == proprietaUsabili[i]){
						datiForma.proprieta[e.property] = e.newValue;
						return;
					}
				} 
			});
		}
		public function get proprietaUsabili():Array{
			return ['x', 'y', 'width', 'height', 'color'];
		}
		
		public function get datiForma():DatiForma 
		{
			return _datiForma;
		}


	}

}

