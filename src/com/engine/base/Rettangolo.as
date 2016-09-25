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
		public function get defaultHandlers():FormaHandlers{
			return new FormaHandlers();
		}
		public function Rettangolo(padre:IContenitore = null, opzioni:Object = null)
		{
			super();
			this._datiForma = new DatiForma(<rettangolo/>, padre);
			this._impostaGestoriDefault();
			//forzo la chiamata all'aggiornamento di ID per aggiornare l'XML associato
			this.id = id;
			//sovrascrivo con i parametri eventualmente passati..
			this._datiForma.leggiParametri(this, opzioni);
			if (padre != null)
			{
				this._datiForma.padre = padre;
				padre.datiForma.proprieta.appendChild(datiForma.proprieta);
			}

		}
		public function cancella():void{
			this.rimuoviDaDisplayList();
		}
		protected function _impostaGestoriDefault():void
		{
			var $this:Rettangolo = this;
			$this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				defaultHandlers.clickHandler($this, e);
			});
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				defaultHandlers.propChangeHandler($this, e);
			});
			
		}
		public function rimuoviDaDisplayList():void{
			var padre:IContenitore = this.datiForma.padre;
			padre.rimuoviFormadaDisplayList(this);
		}
		
		
		public function get datiForma():DatiForma
		{
			return _datiForma;
		}
		
		[Bindable]
		override public function get id():String  { return super.id; }
		
		override public function set id(val:String):void  { super.id = val; }
		
		[Bindable]
		override public function get x():Number  { return super.x; }
		
		override public function set x(val:Number):void  { super.x = val; }
		
		[Bindable]
		override public function get y():Number  { return super.y; }
		
		override public function set y(val:Number):void  { super.y = val; }
		
		[Bindable]
		override public function get width():Number  { return super.width; }
		
		override public function set width(val:Number):void  { super.width = val; }
		
		[Bindable]
		override public function get height():Number  { return super.height; }
		
		override public function set height(val:Number):void  { super.height = val; }
		[Bindable]
		override public function get alpha():Number  { return super.alpha; }
		
		override public function set alpha(val:Number):void  { super.alpha= val; }
		[Bindable]
		public function get borderColor():Number  { return this.getStyle("borderColor"); }
		
		public function set borderColor(val:Number):void  { this.setStyle("borderColor",val); }
		
		public function get listaProprieta():Array
		{
			return ["x", "y", "width", "height", "borderColor","alpha"];
		}
		public function get listaAzioni():Array{
			return [{f:"cancella", c:"cancella rettangolo"}];
		}

	}

}

