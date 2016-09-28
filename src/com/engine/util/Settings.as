package com.engine.util
{
	import flash.filesystem.File;
	import flash.filesystem.FileStream;
	import flash.filesystem.FileMode;
	public class Settings
	{
		public function Settings()
		{
		}
		private static var _fileName:String;
		private static var _xmlData:XML = null;
		/**
		 * ritorna i dati della configurazione
		 * @return XML
		 */
		public static function get xmlData():XML
		{
			
			return _xmlData;
		}
		/**
		 * crea una nuova configurazione XML con i dati passati
		 */
		public static function set xmlData(value:XML):void{
			_xmlData = value;
		}
		/**
		 * nome del file su cui verrà scritta la configurazione
		 */
		public static function get fileName():String
		{
			return _fileName;
		}
		
		public static function set fileName(value:String):void
		{
			_fileName = value;
			_xmlData=new XML();
		}
		/**
		 *legge l'XML da disco solo se esiste il file
		 *  
		 * 
		 */		
		public static function readXML():void
		{
			//apro il file 
			if (_fileName == ""){
				throw new Error("file delle impostazioni non correttamente inizializzato");
			}else{
				
				var file:File = File.applicationStorageDirectory;
				file=file.resolvePath(_fileName);
				var stream:FileStream = new FileStream();
				stream.open(file,FileMode.READ);
				_xmlData = XML(stream.readUTFBytes(stream.bytesAvailable));
				stream.close();
			}
		}
		/**
		 *scrive il file XML su disco 
		 * @throws {Error} se il nome del file non è stato ancora definito
		 */		
		public static function writeXML():void{
			if (_xmlData==null){
				throw new Error("si è tentato di scrivere sul file preferenze ancora da definire");
			}else{
				
  			var file:File = File.applicationStorageDirectory;
				file=file.resolvePath(_fileName);
				var stream:FileStream = new FileStream();
				var outputString:String = '<?xml version="1.0" encoding="utf-8"?>\n';
				outputString += _xmlData.toXMLString();
				outputString = outputString.replace(/\n/g, File.lineEnding);
				stream.open(file, FileMode.WRITE);
				stream.writeUTFBytes(outputString);
				stream.close();
				
			}
		}
	}
}