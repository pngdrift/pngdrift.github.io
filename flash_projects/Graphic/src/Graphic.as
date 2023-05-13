package
{
	import flash.display.Bitmap;
	import flash.display.CapsStyle;
	import flash.display.JointStyle;
	import flash.display.LineScaleMode;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.setInterval;
	import flash.utils.setTimeout;
	
	/**
	 * Показывает график нагрузки какого-то ТОшного сервера
	 */
	public class Graphic extends Sprite
	{
		
		[Embed(source = "Clock.png")]
		private static const Clock:Class;
		
		[Embed(source = "Tank.png")]
		private static const Tank:Class;
		
		[Embed(source = 'Tahoma.ttf', fontName = 'Tahoma', mimeType = 'application/x-font', embedAsCFF = 'false')]
		private static const ttfShablon:Class;
		
		private var container:Sprite;
		
		private var tank:Bitmap = new Tank();
		
		private var clock:Bitmap = new Clock();
		
		public function Graphic()
		{
			//stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			graphics.beginFill(1116422);
			graphics.drawRect(0, 0, 263, 167);
			this.load();
			setInterval(this.load, ((15 * 60) * 1000));
		}
		
		private function load():void
		{
			var loader:URLLoader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.TEXT;
			loader.addEventListener(Event.COMPLETE, this.onLoad);
			loader.addEventListener(IOErrorEvent.IO_ERROR, this.onError);
			loader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onError);
			loader.load(new URLRequest((("https://tankionline.com/s/statistics.txt" + "?rnd=") + Math.random())));
		}
		
		private function onLoad(_arg_1:Event):void
		{
			var _local_2:int;
			var _local_3:int;
			var _local_20:Array;
			var _local_21:Array;
			if (this.container != null)
			{
				removeChild(this.container);
			}
			var _local_4:Array = String(_arg_1.target.data).split(",");
			var _local_5:int = ((96 * 5) + 1);
			_local_4.length = _local_5;
			var _local_6:Number = 0;
			_local_2 = 0;
			while (_local_2 < _local_5)
			{
				if (_local_4[_local_2] > _local_6)
				{
					_local_6 = _local_4[_local_2];
				}
				_local_2++;
			}
			var _local_7:* = 500;
			if (_local_6 > 3000)
			{
				_local_7 = 1000;
			}
			if (_local_6 > 6000)
			{
				_local_7 = 2000;
			}
			if (_local_6 > 12000)
			{
				_local_7 = 4000;
			}
			if (_local_6 > 24000)
			{
				_local_7 = 8000;
			}
			if (_local_6 > 48000)
			{
				_local_7 = 16000;
			}
			if (_local_6 > 96000)
			{
				_local_7 = 0x7D00;
			}
			if (_local_6 > 192000)
			{
				_local_7 = 0xFA00;
			}
			if (_local_6 > 384000)
			{
				_local_7 = 128000;
			}
			if (_local_6 > 768000)
			{
				_local_7 = 256000;
			}
			var _local_8:Number = (_local_6 % _local_7);
			_local_6 = (_local_6 / _local_7);
			_local_6 = Math.ceil(_local_6);
			_local_6 = (_local_6 * _local_7);
			if (_local_8 > (_local_7 * 0.8))
			{
				_local_6 = (_local_6 + _local_7);
			}
			var _local_9:Number = 180;
			var _local_10:Number = 120;
			this.container = new Sprite();
			this.container.x = 53;
			this.container.y = 140;
			addChild(this.container);
			this.container.graphics.lineStyle(1, 3419691, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
			this.container.graphics.moveTo(0, 0);
			this.container.graphics.lineTo(_local_9, 0);
			this.container.graphics.moveTo(0, 0);
			this.container.graphics.lineTo(0, -(_local_10));
			var _local_11:TextField = this.createTextField("0", 9.5, 0x888888);
			_local_11.x = (-(_local_11.width) / 2);
			_local_11.y = 5;
			this.container.addChild(_local_11);
			this.tank.x = -46;
			if (_local_6 >= 100000)
			{
				this.tank.x = (this.tank.x - 4);
			}
			this.tank.y = Math.round((-(_local_10) - (this.tank.height / 2)));
			this.container.addChild(this.tank);
			this.clock.x = (_local_9 + 13);
			this.clock.y = 7;
			this.container.addChild(this.clock);
			var _local_12:Number = (_local_9 / 6);
			var _local_13:int = 4;
			var _local_14:Number = _local_12;
			while (_local_14 <= _local_9)
			{
				this.container.graphics.lineStyle(1, 3419691, 0.5, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
				this.container.graphics.moveTo(_local_14, 0);
				this.container.graphics.lineTo(_local_14, -(_local_10));
				this.container.graphics.lineStyle(1, 3419691, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
				this.container.graphics.moveTo(_local_14, 2);
				this.container.graphics.lineTo(_local_14, -2);
				_local_11 = this.createTextField(_local_13.toString(), 9.5, 0x888888);
				_local_11.x = (_local_14 - (_local_11.width / 2));
				_local_11.y = 5;
				this.container.addChild(_local_11);
				_local_14 = (_local_14 + _local_12);
				_local_13 = (_local_13 + 4);
			}
			var _local_15:Number = (_local_10 / (_local_6 / _local_7));
			_local_13 = _local_7;
			var _local_16:Number = _local_15;
			while (_local_16 <= _local_10)
			{
				this.container.graphics.lineStyle(1, 3419691, 0.5, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
				this.container.graphics.moveTo(0, -(_local_16));
				this.container.graphics.lineTo(_local_9, -(_local_16));
				this.container.graphics.lineStyle(1, 3419691, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
				this.container.graphics.moveTo(-2, -(_local_16));
				this.container.graphics.lineTo(2, -(_local_16));
				_local_11 = this.createTextField(_local_13.toString(), 9.5, 0x888888);
				_local_11.x = (-5 - _local_11.width);
				_local_11.y = (-(_local_16) - (_local_11.height / 2));
				this.container.addChild(_local_11);
				_local_16 = (_local_16 + _local_15);
				_local_13 = (_local_13 + _local_7);
			}
			var _local_17:Date = new Date();
			var _local_18:int = int(((_local_17.hours * 4) + int((_local_17.minutes / 15))));
			this.container.graphics.lineStyle(1, 0x7F0000, 1, true, LineScaleMode.NORMAL, CapsStyle.SQUARE, JointStyle.MITER);
			this.container.graphics.moveTo(((_local_9 * _local_18) / 96), 0);
			this.container.graphics.lineTo(((_local_9 * _local_18) / 96), -(_local_10));
			var _local_19:Array = new Array();
			_local_19[0] = new Array();
			_local_19[1] = new Array();
			_local_19[2] = new Array();
			_local_19[3] = new Array();
			_local_19[4] = new Array();
			_local_3 = 0;
			while (_local_3 < 5)
			{
				if (_local_3 == 0)
				{
					_local_13 = _local_4.shift();
				}
				_local_19[_local_3].push(_local_13);
				_local_2 = 0;
				while (_local_2 < 96)
				{
					_local_13 = _local_4.shift();
					_local_19[_local_3].push(_local_13);
					_local_2++;
				}
				_local_3++;
			}
			_local_3 = 0;
			while (_local_3 < 5)
			{
				_local_4 = _local_19[_local_3];
				_local_5 = 97;
				_local_2 = 0;
				while (_local_2 < (96 - _local_18))
				{
					_local_4.push(_local_4.shift());
					_local_2++;
				}
				_local_20 = new Array();
				_local_21 = new Array();
				_local_2 = 0;
				while (_local_2 < _local_5)
				{
					_local_20.push(((((_local_2 <= _local_18) ? _local_2 : (_local_2 - 1)) * _local_9) / 96));
					_local_21.push(((-(_local_4[_local_2]) * _local_10) / _local_6));
					_local_2++;
				}
				_local_20.push(_local_9);
				_local_21.push(_local_21[0]);
				this.container.graphics.lineStyle(1, ((_local_3 == 4) ? 0x33BB00 : uint(this.multiplyColor(0x555555, (((_local_3 + 3) / 8) + 0.1)))), 1);
				this.container.graphics.moveTo(_local_20[0], _local_21[0]);
				if (_local_18 > 0)
				{
					this.container.graphics.lineTo(((_local_20[0] + _local_20[1]) / 2), ((_local_21[0] + _local_21[1]) / 2));
					_local_2 = 1;
					while (_local_2 < _local_18)
					{
						this.container.graphics.curveTo(_local_20[_local_2], _local_21[_local_2], ((_local_20[_local_2] + _local_20[(_local_2 + 1)]) / 2), ((_local_21[_local_2] + _local_21[(_local_2 + 1)]) / 2));
						_local_2++;
					}
					this.container.graphics.lineTo(_local_20[_local_18], _local_21[_local_18]);
				}
				else
				{
					this.container.graphics.lineTo((_local_20[0] - 3), _local_21[0]);
				}
				this.container.graphics.lineStyle(1, ((_local_3 == 4) ? 0x888888 : uint(this.multiplyColor(0x555555, (((_local_3 + 3) / 8) + 0.1)))), 1);
				this.container.graphics.moveTo(_local_20[(_local_18 + 1)], _local_21[(_local_18 + 1)]);
				this.container.graphics.lineTo(((_local_20[(_local_18 + 1)] + _local_20[((_local_18 + 1) + 1)]) / 2), ((_local_21[(_local_18 + 1)] + _local_21[((_local_18 + 1) + 1)]) / 2));
				_local_2 = ((_local_18 + 1) + 1);
				while (_local_2 < _local_5)
				{
					this.container.graphics.curveTo(_local_20[_local_2], _local_21[_local_2], ((_local_20[_local_2] + _local_20[(_local_2 + 1)]) / 2), ((_local_21[_local_2] + _local_21[(_local_2 + 1)]) / 2));
					_local_2++;
				}
				this.container.graphics.lineTo(_local_20[_local_5], _local_21[_local_5]);
				_local_3++;
			}
		}
		
		private function multiplyColor(rgb:uint, brightness:Number):uint
		{
			var red:uint = (rgb >> 16) & 0xFF;
			var green:uint = (rgb >> 8) & 0xFF;
			var blue:uint = rgb & 0xFF;
			red *= brightness;
			green *= brightness;
			blue *= brightness;
			return (red << 16) | (green << 8) | blue;
		}
		
		private function createTextField(_arg_1:String, _arg_2:int, _arg_3:int):TextField
		{
			var textField:TextField = new TextField();
			textField.selectable = false;
			textField.multiline = false;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.antiAliasType = AntiAliasType.ADVANCED;
			textField.sharpness = 50;
			textField.thickness = 50;
			textField.defaultTextFormat = new TextFormat("Tahoma", _arg_2, _arg_3, null, null, null, null, null, "center");
			textField.embedFonts = true;
			textField.text = _arg_1;
			return (textField);
		}
		
		private function onError(e:Event):void
		{
			setTimeout(this.load, 10000);
		}
	
	}
}