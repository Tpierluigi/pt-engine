package com.engine.base
{
	import com.engine.componenti.Cerchio;
	import com.engine.componenti.Immagine;
	import com.engine.componenti.Rettangolo;
	import flash.events.MouseEvent;
	import mx.events.PropertyChangeEvent;
	import spark.components.BorderContainer;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Cornice extends BorderContainer implements IContenitore
	{
		protected var _contenitore:DatiContenitore;
		
		public function Cornice(padre:IContenitore = null, opzioni:Object = null)
		{
			super();
			this._contenitore = new DatiContenitore(<cornice/>, padre);
			this._impostaGestoriDefault();
			//sovrascrivo con i parametri eventualmente passati..
			this._contenitore.leggiParametri(this, opzioni);
			if (padre != null)
			{
				this._contenitore.padre = padre;
				padre.forma.proprieta.appendChild(forma.proprieta);
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
			//gestione della rimozione/aggiunta di un elemento figlio
			this.addEventListener(FormaEvent.FORMA_AGGIUNTA, function(e:FormaEvent):void
			{
				(defaultHandlers as ContenitoreHandlers).handlerAggiunto($this, e);
			});
			this.addEventListener(FormaEvent.FORMA_RIMOSSA, function(e:FormaEvent):void
			{
				(defaultHandlers as ContenitoreHandlers).handlerRimosso($this, e);
			});
		}
		
		/* INTERFACE com.engine.base.IContenitore */
		
		public function aggiungiForma(forma:IForma):void
		{
			_contenitore.aggiungiForma(this, forma);
		}
		
		public function rimuoviFormadaDisplayList(forma:IForma):void
		{
			_contenitore.rimuoviFormadaDisplayList(this, forma);
		}
		
		public function rimuoviDaDisplayList():void
		{
			_contenitore.padre.rimuoviFormadaDisplayList(this);
		}
		
		public function get forma():DatiForma
		{
			return _contenitore as DatiForma;
		}

		public function nuovoCerchio():void{
			this.aggiungiForma(new Cerchio(null,{id:"forma_"+(new Date().time)}));
		}
		
		public function nuovoRettangolo():void
		{
			this.aggiungiForma(new Rettangolo(null, {id: "forma_" + (new Date().time)}));
		}
		
		public function nuovaImmagine():void
		{
			this.aggiungiForma(new Immagine(null, {width: 100, height: 100, source: "filename", id: "forma_" + (new Date().time)}));
		}
		
		public function nuovaCornice():void
		{
			this.aggiungiForma(new Cornice(null, {width: 100, height: 100, id: "forma_" + (new Date().time), borderColor: 0}));
		}
		
		/*
		 * *********************************
		 * proprietà editabili
		 * *********************************
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
		override public function get width():Number  { return super.width; }
		
		override public function set width(val:Number):void  { super.width = val; }
		
		[Bindable]
		override public function get height():Number  { return super.height; }
		
		override public function set height(val:Number):void  { super.height = val; }
		
		[Bindable]
		public function get borderColor():Object  { return this.getStyle("borderColor"); }
		
		public function set borderColor(value:Object):void  { this.setStyle("borderColor", value); }
		
		[Bindable]
		public function get borderWidth():Number  { return this.getStyle("borderWidth"); }
		
		public function set borderWidth(value:Number):void  { this.setStyle("borderWidth", value); }
		
		[Bindable]
		public function get borderVisible():Boolean  { return this.getStyle("borderVisible"); }
		
		public function set borderVisible(value:Boolean):void  { this.setStyle("borderVisible", value); }
		
		[Bindable]
		public function get borderStyle():String  { return this.getStyle("borderStyle"); }
		
		public function set borderStyle(value:String):void  { this.setStyle("borderStyle", value); }
		
		[Bindable]
		public function get backgroundColor():uint  { return this.getStyle("backgroundColor"); }
		
		public function set backgroundColor(value:uint):void  { this.setStyle("backgroundColor", value); }
		
		[Bindable]
		public function get backgroundAlpha():Number  { return this.getStyle("backgroundAlpha"); }
		
		public function set backgroundAlpha(value:Number):void  { this.setStyle("backgroundAlpha", value); }
		
		[Bindable]
		public function get backgroundImage():String  { return this.getStyle("backgroundImage"); }
		
		public function set backgroundImage(value:String):void  { this.setStyle("backgroundImage", value); }
		
		[Bindable]
		public function get color():String  { return this.getStyle("color"); }
		
		public function set color(value:String):void  { this.setStyle("color", value); }
		
		public function get listaProprieta():Array
		{
			return ["x", "y", "width", "height", "borderColor", "borderStyle", "borderWidth", "borderVisible", "backgroundColor", "backgroundAlpha", "backgroundImage", "color"];
		}
		
		public function get listaAzioni():Array
		{
			return [
				{f: "nuovoRettangolo", c: "Nuovo rettangolo"}, 
				{f: "nuovoCerchio", c: "Nuovo cerchio"}, 
				{f: "nuovaImmagine", c: "Nuova immagine"}, 
				{f: "nuovaCornice", c: "Nuova cornice"}, 
				{f: "cancella", c: "cancella"}]
		}
		
		public function get defaultHandlers():FormaHandlers
		{
			return new ContenitoreHandlers();
		}
	
	}

}