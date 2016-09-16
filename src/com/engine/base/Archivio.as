package com.engine.base
{
	import flash.filesystem.File;
	import flash.net.FileReference;
	import mx.utils.DirectoryEnumeration;
	import spark.primitives.BitmapImage;
	
	/**
	 * ...
	 * @author pier
	 */
	public class Archivio
	{
		private var _path:String
		protected  var elementi:DatiFile;
		public function Archivio()
		{
		
		}
		
		private function readContents(dir:String,df:DatiFile):void
		{
			var f:File = new File(dir);
			df = new DatiFile();
			var entries:Array = f.getDirectoryListing();
			for (var i:int = 0; i < entries.length; i++)
			{
				f = File(entries[i]);
				df._figli[i] = new DatiFile();
				if (f.isDirectory)
				{
					readContents(f.nativePath,df._figli[i]);
				}
				else
				{
					processa(f,df._figli[i]);
				}
			}
		}
		
		private function processa(f:File,df:DatiFile):void
		{
			var ext:String = f.extension.toLowerCase();
			//se è un file grafico..
			df._nome = f.name;
			if ((new Array("jpg", "gif", "png").indexOf(ext)) < 0){
				df._contenuto = new BitmapImage();
				var image:BitmapImage = df._contenuto as BitmapImage;
				image.source = f.nativePath;
			} else{
				df._contenuto = null;
			}
		}
		
		public function get path():String
		{
			return _path;
		}
		
		public function set path(value:String):void
		{
			_path = value;
			readContents(_path, elementi);
		}
	}

}

class DatiFile
{
	internal var _nome:String;
	internal var _contenuto:Object;
	internal var _figli:Vector.<DatiFile>;
	public function DatiFile()
	{
		_contenuto = null;
		_figli = new Vector.<DatiFile>();
	}
}
