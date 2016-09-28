package com.engine.componenti
{
	import com.engine.base.DatiForma;
	import com.engine.base.FormaHandlers;
	import com.engine.base.IContenitore;
	import com.engine.base.IForma;
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
		
		protected var _forma:DatiForma;
		public function get defaultHandlers():FormaHandlers{
			return new FormaHandlers();
		}
		public function Rettangolo(padre:IContenitore = null, opzioni:Object = null)
		{
			super();
			this._forma = new DatiForma(<rettangolo/>, padre);
			this._impostaGestoriDefault();
			//forzo la chiamata all'aggiornamento di ID per aggiornare l'XML associato
			this.id = id;
			//sovrascrivo con i parametri eventualmente passati..
			this._forma.leggiParametri(this, opzioni);
			if (padre != null)
			{
				this._forma.padre = padre;
				padre.forma.proprieta.appendChild(forma.proprieta);
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
			var padre:IContenitore = this.forma.padre;
			padre.rimuoviFormadaDisplayList(this);
		}
		
		
		public function get forma():DatiForma
		{
			return _forma;
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
		public function get borderColor():Object{return this.getStyle("borderColor");}
		public function set borderColor(value:Object):void{this.setStyle("borderColor", value);}
		[Bindable]
		public function get borderWidth():Number{return this.getStyle("borderWidth");}
		public function set borderWidth(value:Number):void{this.setStyle("borderWidth", value);}
		[Bindable]
		public function get borderVisible():Boolean{return this.getStyle("borderVisible");}
		public function set borderVisible(value:Boolean):void{this.setStyle("borderVisible", value);}
		[Bindable]
		public function get borderStyle():String{return this.getStyle("borderStyle");}
		public function set borderStyle(value:String):void{this.setStyle("borderStyle", value); }
		[Bindable]
		public function get backgroundColor():uint{return this.getStyle("backgroundColor");}
		public function set backgroundColor(value:uint):void{this.setStyle("backgroundColor", value);}
		[Bindable]
		public function get backgroundAlpha():Number{return this.getStyle("backgroundAlpha");}
		public function set backgroundAlpha(value:Number):void{this.setStyle("backgroundAlpha", value); }
		[Bindable]
		public function get backgroundImage():String{return this.getStyle("backgroundImage");}
		public function set backgroundImage(value:String):void{this.setStyle("backgroundImage", value); }
		[Bindable]
		public function get color():String{return this.getStyle("color");}
		public function set color(value:String):void{this.setStyle("color", value); }
		
		public function get listaProprieta():Array
		{
			return ["x", "y", "width", "height", "borderColor", "alpha", "borderWidth", "borderVisible", "backgroundColor",
					"backgroundAlpha","backgroundImage","color"];
		}
		public function get listaAzioni():Array{
			return [{f:"cancella", c:"cancella rettangolo"}];
		}

	}

}

