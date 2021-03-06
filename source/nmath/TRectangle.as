package nmath {
	import nmath.vectors.Vector2D;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class TRectangle implements IReusable {
		private static var _pool:Pool = Pool.getInstance();

        private var _disposed:Boolean;
		
		private var _position:Vector2D;
		private var _size:Vector2D;
		
		public function TRectangle() {
			_position = Vector2D.ZERO;
			_size     = Vector2D.ZERO;
		};
		
		public static function get EMPTY():TRectangle {
			var results:TRectangle = _pool.get(TRectangle) as TRectangle;
			
			if (!results) {
				results = new TRectangle();
				_pool.allocate(TRectangle, 1);
			}
			
			return results;
		};
		
		public function get reflection():Class {
			return TRectangle;
		};

        public function get disposed():Boolean {
            return _disposed;
        };
		
		public function get position():Vector2D {
			return _position;
		};
		
		public function get size():Vector2D {
			return _size;
		};

        public function get left():Number {
            return _position.x;
        };

        public function get right():Number {
            return _position.x + _size.x;
        };

        public function get top():Number {
            return _position.y;
        };

        public function get bottom():Number {
            return _position.y + _size.y;
        };

		public function isPointInside(pPosition:Vector2D):Boolean {
			if (pPosition.x < _position.x || pPosition.y < _position.y ||
				pPosition.x > _size.x || pPosition.y > _size.y) {
				return false;
			}
			
			return true;
		};

        public function zero():void {
            _position.zero();
            _size.zero();
        };
		
		public function poolPrepare():void {
			_position.zero();
			_size.zero();
		};
		
		public function dispose():void {
			_pool.put(_position);
			_pool.put(_size);
			
			_position = null;
			_size     = null;

            _disposed = true;
		};
	}
}