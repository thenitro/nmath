package nmath.vectors {
	import npooling.IReusable;
	import npooling.Pool;
	
	public class TVector3D implements IReusable {
		private static var _pool:Pool = Pool.getInstance();

        private var _disposed:Boolean;
		
		private var _x:Number;
		private var _y:Number;
		private var _z:Number;
		
		public function TVector3D(pX:Number=0.0, pY:Number=0.0, pZ:Number=0.0) {
			_x = pX;
			_y = pY;
			_z = pZ;
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
		
		public function get z():Number {
			return _z;
		};
		
		public function set z(pValue:Number):void {
			_z = pValue;
		};		
		
		public static function get ZERO():TVector3D {
			var result:TVector3D = _pool.get(TVector3D) as TVector3D;
			
			if (!result) {
				_pool.allocate(TVector3D, 1);
				result = new TVector3D();
			}
			
			return result;
		};
		
		public static function distance(pVectorA:TVector3D, 
										pVectorB:TVector3D):Number {
			return Math.sqrt(distanceSquared(pVectorA, pVectorB));
		};
		
		public static function distanceSquared(pVectorA:TVector3D, 
											   pVectorB:TVector3D):Number {
			var dx:Number = pVectorB.x - pVectorA.x;
			var dy:Number = pVectorB.y - pVectorA.y;
			var dz:Number = pVectorB.z - pVectorA.z;
			
			return dx * dx + dy * dy + dz * dz;
		};

        public static function lerp(pA:TVector3D, pB:TVector3D, pTime:Number):TVector3D {
            var result:TVector3D = TVector3D.ZERO;

                result.x = (1.0 - pTime) * pA.x + pTime * pB.x;
                result.y = (1.0 - pTime) * pA.y + pTime * pB.y;
                result.z = (1.0 - pTime) * pA.z + pTime * pB.z;

            return result;
        };
		
		public function get reflection():Class {
			return TVector3D;
		};

        public function get disposed():Boolean {
            return _disposed;
        };
		
		public function length():Number {
			return Math.sqrt(lengthSquared());
		};
		
		public function lengthSquared():Number {
			return (_x * _x) + (_y * _y) + (_z * _z);
		};
		
		public function reverse(pNewInstance:Boolean = false):TVector3D {
			return multiplyScalar(-1, pNewInstance);
		};
		
		public function add(pVectorB:TVector3D, 
							pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
				
				result.x += pVectorB.x;
				result.y += pVectorB.y;
				result.z += pVectorB.z;
				
			return result;
		};
		
		public function addScalar(pScalar:Number, 
								  pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x += pScalar;
				result.y += pScalar;
				result.z += pScalar;
				
			return result;
		};
		
		public function substract(pVectorB:TVector3D, 
								 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x -= pVectorB.x;
				result.y -= pVectorB.y;
				result.z -= pVectorB.z;
			
			return result;
		};
		
		public function substactScalar(pScalar:Number,
								 	   pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x -= pScalar;
				result.y -= pScalar;
				result.z -= pScalar;
			
			return result;
		};
		
		public function multiply(pVectorB:TVector3D, 
								 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x *= pVectorB.x;
				result.y *= pVectorB.y;
				result.z *= pVectorB.z;
			
			return result;
		};
		
		public function multiplyScalar(pScalar:Number, 
									   pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x *= pScalar;
				result.y *= pScalar;
				result.z *= pScalar;
			
			return result;
		};
		
		public function divide(pVectorB:TVector3D, 
								 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x /= pVectorB.x;
				result.y /= pVectorB.y;
				result.z /= pVectorB.z;
			
			return result;
		};
		
		public function divideScalar(pScalar:Number, 
									 pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x /= pScalar;
				result.y /= pScalar;
				result.z /= pScalar;
			
			return result;
		};
		
		public function distanceTo(pTarget:TVector3D):Number {
			return distance(this, pTarget);
		};

        public function dotProduct(pTarget:TVector3D):Number {
            return x * pTarget.x + y * pTarget.y + z * pTarget.z;
        };

		public function floor(pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x = Math.floor(result.x);
				result.y = Math.floor(result.y);
				result.z = Math.floor(result.z);
			
			return result;
		};
		
		public function ceil(pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x = Math.ceil(result.x);
				result.y = Math.ceil(result.y);
				result.z = Math.ceil(result.z);
			
			return result;
		};
		
		public function round(pNewInstance:Boolean = false):TVector3D {
			var result:TVector3D = pNewInstance ? clone() : this;
			
				result.x = Math.round(result.x);
				result.y = Math.round(result.y);
				result.z = Math.round(result.z);
			
			return result;
		};
		
		public function zero():void {
			x = 0;
			y = 0;
			z = 0;
		};
		
		public function clone():TVector3D {
			var result:TVector3D = ZERO;
			
				result.x = x;
				result.y = y;
				result.z = z;
			
			return result;
		};
		
		public function poolPrepare():void {
			zero();
		};
		
		public function dispose():void {
			zero();

            _disposed = true;
		};
		
		public function toString():String {
			return "[object TVector3D: x=" + x + ", y= " + y + ", z= " + z + " ]";
		};
	}
}