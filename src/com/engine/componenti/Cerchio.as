package com.engine.componenti
{
	import com.engine.base.IContenitore;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Vector3D;
	import flash.geom.Matrix3D;
	import flash.geom.Matrix;
	import mx.events.PropertyChangeEvent;
	import mx.geom.TransformOffsets;
	import mx.core.DesignLayer;
	import flash.display.DisplayObjectContainer;
	import com.engine.base.FormaHandlers;
	import com.engine.base.DatiForma;
	import com.engine.base.IForma;
	import mx.graphics.SolidColor;
	import mx.graphics.SolidColorStroke;
	import spark.components.Group;
	import spark.primitives.Ellipse;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Cerchio extends Group implements IForma
	{
		protected var _forma:DatiForma;
		protected var _cerchio:Ellipse;
		protected var _bordo:SolidColorStroke;
		protected var _riempimento:SolidColor;
		public function Cerchio(padre:IContenitore = null, opzioni:Object = null)
		{
			super();
			_forma = new DatiForma(<cerchio/>,padre);
			_cerchio = new Ellipse();
			_bordo = new SolidColorStroke();
			_riempimento = new SolidColor();
			_cerchio.fill = _riempimento;
			_cerchio.stroke = _bordo;
			addElement(_cerchio);
			this._impostaGestoriDefault();
			//sovrascrivo con i parametri eventualmente passati..
			forma.leggiParametri(this, opzioni);
			if (padre != null)
			{
				forma.padre = padre;
				padre.forma.proprieta.appendChild(forma.proprieta);
			}
		}
		
		protected function _impostaGestoriDefault():void
		{
			var $this:Cerchio = this;
			$this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				defaultHandlers.clickHandler($this, e);
			});
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				defaultHandlers.propChangeHandler($this, e);
			});
		
		}
		
		public function get defaultHandlers():FormaHandlers
		{
			return new FormaHandlers();
		}
		
		public function rimuoviDaDisplayList():void
		{
			var padre:IContenitore = this.forma.padre;
			padre.rimuoviFormadaDisplayList(this);
		
		}
		
		public function cancella():void{
			this.rimuoviDaDisplayList();
		}

		
		/* INTERFACE com.engine.base.IForma */
		public function get forma():DatiForma
		{
			return _forma;
		}
		
		public function get listaProprieta():Array
		{
			return ["id", "x", "y", "width", "height", "borderColor", "borderWeight", "backgroundColor", "alpha"];
		}
		
		public function get listaAzioni():Array
		{
			return [{f: "cancella", c: "cancella cerchio"}];
		}
		
		/*
		 * proprietà editabili
		 * */
		
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
		override public function get width():Number  { 
			return super.width; 
		}
		
		override public function set width(val:Number):void  { 
			super.width = val; 
			_cerchio.width = val;
		}
		
		[Bindable]
		override public function get height():Number  { 
			return super.height; 
		}
		
		override public function set height(val:Number):void  { 
			super.height = val; 
			_cerchio.height = val;
		}
		
		[Bindable]
		override public function get alpha():Number  { return super.alpha; }
		
		override public function set alpha(val:Number):void  { super.alpha = val; }
		
		[Bindable]
		public function get backgroundColor():Number{
			return _riempimento.color;
		}
		public function set backgroundColor(val:Number):void{
			_riempimento.color=val;
		}		
		[Bindable]
		public function get borderColor():Number{
			return _bordo.color;
		}
		public function set borderColor(val:Number):void{
			_bordo.color=val;
		}
		[Bindable]
		public function get borderWeight():Number{
			return _bordo.weight;
		}
		public function set borderWeight(val:Number):void{
			_bordo.weight=val;
		}
		
	}

}