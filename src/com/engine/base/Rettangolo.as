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
		
		public function Rettangolo(padre:IForma = null, opzioni:Object = null)
		{
			super();
			this._datiForma = new DatiForma(<rettangolo/>, padre);
			this._impostaGestoriDefault();
			this.id = id;
			//sovrascrivo con i parametri eventualmente passati..
			this._datiForma.leggiParametri(this, opzioni);
			if (padre != null)
			{
				this._datiForma.padre = padre;
				padre.datiForma.proprieta.appendChild(datiForma.proprieta);
			}
		
			//TODO: aggiungo il gruppo (che contiene il rettangolo) alla lista degli elementi
			//di cui è composto il componente
		}
		
		protected function _impostaGestoriDefault():void
		{
			var $this:Rettangolo = this;
			$this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				$this.dispatchEvent(new FormaEvent(FormaEvent.CLICCATO, true));
			});
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				datiForma.proprieta.@[e.property] = e.newValue;
				$this.dispatchEvent(new FormaEvent(FormaEvent.REFRESH_CP, true));
			});
			
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

	}

}

