package com.engine.base 
{
	import flash.events.MouseEvent;
	import mx.events.PropertyChangeEvent;
	import spark.components.BorderContainer;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Cornice extends BorderContainer implements IContenitore 
	{
		protected var _datiForma:DatiForma;
		
		public function Cornice(padre:IContenitore = null, opzioni:Object = null) 
		{
			super();
			this._datiForma = new DatiForma(<cornice/>, padre);
			this._impostaGestoriDefault();
			//sovrascrivo con i parametri eventualmente passati..
			this._datiForma.leggiParametri(this, opzioni);
			if (padre != null)
			{
				this._datiForma.padre = padre;
				padre.datiForma.proprieta.appendChild(datiForma.proprieta);
			}
		}
		protected function _impostaGestoriDefault():void
		{
			var $this:Cornice = this;
			$this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				defaultHandlers.clickHandler($this, e);
			});
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				defaultHandlers.propChangeHandler($this, e);
			});
			
		}		
		
		/* INTERFACE com.engine.base.IContenitore */
		
		public function aggiungiForma(forma:IForma):void 
		{
			
		}
		
		public function rimuoviFormadaDisplayList(forma:IForma):void 
		{
			
		}
		
		public function get datiForma():DatiForma 
		{
			return _datiForma;
		}
		
		public function nuovoRettangolo():void{
			this.aggiungiForma(new Rettangolo(null,{id:"forma_"+(new Date().time)}));
		}
		public function nuovaImmagine():void 
		{
			this.aggiungiForma(new Immagine(null,{width:100,height:100,source:"filename",id:"forma_"+(new Date().time)}));
		}
		public function nuovaCornice():void 
		{
			this.aggiungiForma(new Cornice(null,{width:100,height:100,id:"forma_"+(new Date().time),borderColor:0}));
		}
		
		/*
		 * *********************************
		 * proprietà editabili
		 * *********************************
		 * */
		
		[Bindable]
		override public function get id():String  { return super.id; }
		override public function set id(val:String):void{ super.id = val; }
		
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
			return ["x", "y", "width", "height", "borderColor", "borderStyle",
					"borderWidth", "borderVisible", "backgroundColor", "backgroundAlpha",
					"backgroundImage","color"];
		}
		public function get listaAzioni():Array{
			return [
				{f:"nuovoRettangolo", c:"Nuovo rettangolo"},
				{f:"nuovaImmagine", c:"Nuova immagine"},
				{f:"nuovaCornice", c:"Nuova cornice"},
				{f:"cancella", c:"cancella"}
				]
		}
		
		public function get defaultHandlers():FormaHandlers 
		{
			return new ContenitoreHandlers();
		}
		
		public function rimuoviDaDisplayList():void 
		{
			this.datiForma.padre.rimuoviFormadaDisplayList(this);
		}
		
	}

}