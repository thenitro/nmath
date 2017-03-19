package nmath.vectors {
    import flash.geom.Point;

    import nmath.Random;
	import nmath.NMath;
	
	import npooling.IReusable;
	import npooling.Pool;
	
	public final class Vector2D implements IReusable {
		private static var _pool:Pool = Pool.getInstance();

        private var _disposed:Boolean;

		private var _x:Number;
		private var _y:Number;
		
		private var _depth:Number;
		
		public function Vector2D(pX:Number = 0, pY:Number = 0) {
			_x = pX;
			_y = pY;
		};
		
		public static function get ZERO():Vector2D {
			var result:Vector2D = _pool.get(Vector2D) as Vector2D;
			
			if (!result) {
				_pool.allocate(Vector2D, 1);
				result = new Vector2D();
			}
			
			return result;
		};

        public static function fromPoint(pTarget:Point):Vector2D {
            var result:Vector2D = ZERO;
                result.fromPoint(pTarget);

            return result;
        };

		[Inline]
		public static function distanceSquared(pVectorA:Vector2D, pVectorB:Vector2D):Number {
			var dx:Number = pVectorB.x - pVectorA.x;
			var dy:Number = pVectorB.y - pVectorA.y;
			
			return dx * dx + dy * dy;  
		};

		[Inline]
		public static function distance(pVectorA:Vector2D, pVectorB:Vector2D):Number {
			return Math.sqrt(distanceSquared(pVectorA, pVectorB));
		};

        public static function angleBetween(pVectorA:Vector2D, pVectorB:Vector2D):Number {
            return Math.atan2(pVectorA.y - pVectorB.y, pVectorA.x - pVectorB.x);
        };
		
		public static function equals(pVectorA:Vector2D, pVectorB:Vector2D):Boolean {
			return pVectorA.x == pVectorB.x && pVectorA.y == pVectorB.y;
		};
		
		public static function direction(pVectorA:Vector2D, pVectorB:Vector2D):Number {
			return Math.atan2(pVectorB.y - pVectorA.y, pVectorB.x - pVectorA.x);
		};

        public static function lerp(pA:Vector2D, pB:Vector2D, pTime:Number):Vector2D {
            var result:Vector2D = Vector2D.ZERO;

                result.x = NMath.lerp(pA.x, pB.x, pTime);
                result.y = NMath.lerp(pA.y, pB.y, pTime);

            return result;
        };
		
		public function get reflection():Class {
			return Vector2D;
		};

        public function get disposed():Boolean {
            return _disposed;
        };
		
		public function get depth():Number {
			return _depth;
		};
		
		public function set depth(pValue:Number):void {
			_depth = pValue;
		};
		
		public function get x():Number {
			return _x;
		};
		
		public function set x(pValue:Number):void {
			_x = pValue;
		};
		
		public function get y():Number {
			return _y;
		};
		
		public function set y(pValue:Number):void {
			_y = pValue;
		};
		
		public function length():Number {
			return Math.sqrt(lengthSquared());
		};
		
		public function lengthSquared():Number {
			return (_x * _x) + (_y *_y);
		};

        public function fromPoint(pInput:Point):void {
            x = pInput.x;
            y = pInput.y;
        };
		
		public function substract(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x -= pTarget.x;
				result.y -= pTarget.y;
			
			return result;
		};
		
		public function substractScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x -= pTarget;
				result.y -= pTarget;
			
			return result;
		};
		
		public function add(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x += pTarget.x;
				result.y += pTarget.y;
			
			return result;
		};
		
		public function addScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x += pTarget;
				result.y += pTarget;
			
			return result;
		};
		
		public function multiply(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x *= pTarget.x;
				result.y *= pTarget.y;
			
			return result;
		};
		
		public function multiplyScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x *= pTarget;
				result.y *= pTarget;
			
			return result;
		};
		
		public function divide(pTarget:Vector2D, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x /= pTarget.x;
				result.y /= pTarget.y;
			
			return result;
		};
		
		public function divideScalar(pTarget:Number, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.x /= pTarget;
				result.y /= pTarget;
			
			return result;
		};
		
		public function normalize():void {
			var l:Number = length();
			
			if (l > 0) {
				l = 1 / l;
			}
			
			_x *= l;
			_y *= l;
		};
		
		public function inverse():void {
			_x *= -1;
			_y *= -1;
		};

		public function fromAngle(pAngleInRadians:Number, pLength:Number = 1, pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? Vector2D.ZERO : this;

				result.x = Math.cos(pAngleInRadians) * pLength;
				result.y = Math.sin(pAngleInRadians) * pLength;

			return result;
		};
		
		public function angle():Number {
			return Math.atan2(_y, _x);
		};
		
		public function distanceTo(pTarget:Vector2D):Number {
			return distance(this, pTarget);
		};

		public function distanceToSquared(pTarget:Vector2D):Number {
			return distanceSquared(this, pTarget);
		}

        public function angleTo(pTarget:Vector2D):Number {
            return angleBetween(this, pTarget);
        };
		
		public function dotProduct(pTarget:Vector2D):Number {
			return x * pTarget.x + y * pTarget.y;
		};
		
		public function crossProduct(pTarget:Vector2D):Number {
			return x * pTarget.y - y * pTarget.x;
		};
		
		public function randomize(pMin:Number, pMax:Number):void {
			x = Random.range(pMin, pMax);
			y = Random.range(pMin, pMax);
		};
		
		public function equals(pVectorB:Vector2D):Boolean {
			return x == pVectorB.x && y == pVectorB.y;
		};
		
		public function floor(pNewInstance:Boolean = false):Vector2D {
			var result:Vector2D = pNewInstance ? clone() : this;
			
				result.x = Math.floor(result.x);
				result.y = Math.floor(result.y);
				
			return result;
		};
		
		public function ceil(pNewInstance:Boolean = false):Vector2D {
			var result:Vector2D = pNewInstance ? clone() : this;
			
				result.x = Math.ceil(result.x);
				result.y = Math.ceil(result.y);
			
			return result;
		};
		
		public function round(pNewInstance:Boolean = false):Vector2D {
			var result:Vector2D = pNewInstance ? clone() : this;
			
				result.x = Math.round(result.x);
				result.y = Math.round(result.y);
			
			return result;
		};
		
		public function clamp(pMinValue:Number, pMaxValue:Number, 
							  pClone:Boolean = false):Vector2D {
			var result:Vector2D = pClone ? clone() : this;
				result.fromAngle(result.angle(), 
								 NMath.clamp(result.length(), pMinValue,
															  pMaxValue));
			
			return result;
		};
		
		public function direction(pTarget:Vector2D):Number {
			return Vector2D.direction(this, pTarget);
		};
		
		public function zero():void {
			x = 0;
			y = 0;
		};
		
		public function clone():Vector2D {
			var result:Vector2D = Vector2D.ZERO;
			
				result.x = _x;
				result.y = _y;
				
			return result;
		};

        public function copy(pSource:Vector2D):void {
            _x = pSource.x;
            _y = pSource.y;
        };
		
		public function poolPrepare():void {
			zero();
		};
		
		public function dispose():void {
			zero();

            _disposed = true;
		};
		
		public function toString():String {
			return "[object Vector2D: x=" + x + ", y= " + y + " ]";
		};
	}
}