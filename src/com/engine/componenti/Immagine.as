package com.engine.componenti
{
	import com.engine.applicazione.Applicazione;
	import com.engine.base.DatiForma;
	import com.engine.base.FormaEvent;
	import com.engine.base.FormaHandlers;
	import com.engine.base.IContenitore;
	import com.engine.base.IForma;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filesystem.File;
	import flash.net.FileFilter;
	import mx.controls.Image;
	import mx.events.PropertyChangeEvent;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Immagine extends Image implements IForma
	{
		protected var _forma:DatiForma;
		protected var _sourcePath:String;
		
		public function Immagine(padre:IContenitore = null, opzioni:Object = null)
		{
			super();
			this._forma = new DatiForma(<immagine/>, padre);
			_impostaGestoriDefault();
			this._forma.leggiParametri(this, opzioni);
			this.id = id;
			if (padre != null)
			{
				this._forma.padre = padre;
				padre.forma.proprieta.appendChild(forma.proprieta);
			}
		}
		public function get defaultHandlers():FormaHandlers{
			return new FormaHandlers();
		}
		public function get forma():DatiForma
		{
			return _forma;
		}
		public function rimuoviDaDisplayList():void{
			var padre:IContenitore = this.forma.padre;
			padre.rimuoviFormadaDisplayList(this);
		}
		protected function _impostaGestoriDefault():void
		{
			var $this:Immagine = this as Immagine;
			/*
			 * gestore per segnalare il possibile utilizzo del property inspector
			 * */
			$this.addEventListener(MouseEvent.CLICK, function(e:MouseEvent):void
			{
				$this.dispatchEvent(new FormaEvent(FormaEvent.CLICCATO, true));
				e.stopImmediatePropagation();
			});
			/*
			 * questo per segnalare il cambio delle proprietà e la loro trascrizione sull'XML
			 * */
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, function(e:PropertyChangeEvent):void
			{
				forma.proprieta.@[e.property] = e.newValue;
				$this.dispatchEvent(new FormaEvent(FormaEvent.REFRESH_CP, true));
			});
			/*
			 * questo gestore viene usato per aggiornare l'immangine non appena
			 * che il bulkloader dell'applicazione abbia terminato il caricamento di tutti gli assets
			 * e sfrutta la capture phase (sono gli elementi interni dell'app che devono
			 * essere aggiornati, e non il contrario)
			 * */
			this.addEventListener(Event.COMPLETE, function(e:Event):void
			{
				var app:Applicazione = e as Applicazione;
				source = app.loader.getBitmap(_sourcePath);
			}, true);
		
		}
		
		public function cancella():void
		{
			this.rimuoviDaDisplayList();
		}
		
		public function cambiaImg():void
		{
			var f:File = new File();
			var $this:Immagine = this;
			f.browseForOpen("Seleziona file",[new FileFilter("Images", "*.jpg;*.gif;*.png")]);
			f.addEventListener(Event.SELECT, function(e:Event):void
			{
				f = e.target as File;
				$this.sourcePath = f.nativePath;
			});
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
		
		override public function set alpha(val:Number):void  { super.alpha = val; }
		
		[Bindable]
		public function set sourcePath(val:String):void
		{
			this.source = val;
			_sourcePath = val;
			this.dispatchEvent(new FormaEvent(FormaEvent.AGGIORNA_ASSETS, true));
		}
		
		public function get sourcePath():String
		{
			return _sourcePath;
		}
		
		public function get listaProprieta():Array
		{
			return ["x", "y", "width", "height", "alpha", "sourcePath"];
		}
		
		public function get listaAzioni():Array
		{
			return [{f: "cancella", c: "cancella immagine"}, {f: "cambiaImg", c: "Cambia immagine"}];
		}
	}

}