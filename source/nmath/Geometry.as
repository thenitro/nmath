package nmath {
	import flash.errors.IllegalOperationError;

    import starling.display.DisplayObject;

    public final class Geometry {
		public function Geometry() {
			throw new IllegalOperationError("Geometry is static class!");
		};
		
		public static function resizeDisplayObject(pTarget:DisplayObject,
												   pWidth:Number, pHeight:Number,
                                                   pDetermineFunction:Function):DisplayObject {
			if (pWidth && pHeight) {
				pTarget.scaleX = 1.0;
				pTarget.scaleY = 1.0;
				
				var scale:Number = pDetermineFunction(pTarget.width, pTarget.height, pWidth, pHeight);
				
				pTarget.scaleX = scale;
				pTarget.scaleY = scale;
			}

            return pTarget;
		};
		
		public static function determineMinScale(pSourceWidth:Number, pSourceHeight:Number, 
											     pTargetWidth:Number, pTargetHeight:Number):Number {
			var scaleX:Number = pTargetWidth  / pSourceWidth;
			var scaleY:Number = pTargetHeight / pSourceHeight;
			
			return Math.min(scaleX, scaleY);
		};
		
		public static function determineMaxScale(pSourceWidth:Number, pSourceHeight:Number, 
											     pTargetWidth:Number, pTargetHeight:Number):Number {
			var scaleX:Number = pTargetWidth  / pSourceWidth;
			var scaleY:Number = pTargetHeight / pSourceHeight;
			
			return Math.max(scaleX, scaleY);
		};
	}
}