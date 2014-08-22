package nmath {
    import nmath.vectors.Vector2D;

    import npooling.IReusable;
    import npooling.Pool;

    public class TQuad implements IReusable {
        private static var _pool:Pool = Pool.getInstance();

        private var _a:Vector2D;
        private var _b:Vector2D;
        private var _c:Vector2D;
        private var _d:Vector2D;

        private var _disposed:Boolean;

        public function TQuad() {
            _a = Vector2D.ZERO;
            _b = Vector2D.ZERO;
            _c = Vector2D.ZERO;
            _d = Vector2D.ZERO;
        };

        public static function get NEW():TQuad {
            var result:TQuad = _pool.get(TQuad) as TQuad;

            if (!result) {
                result = new TQuad();
                _pool.allocate(TQuad, 1);
            }

            return result;
        };

        public function get reflection():Class {
            return TQuad;
        };

        public function get disposed():Boolean {
            return _disposed;
        };

        public function get a():Vector2D {
            return _a;
        };

        public function get b():Vector2D {
            return _b;
        };

        public function get c():Vector2D {
            return _c;
        };

        public function get d():Vector2D {
            return _d;
        };

        public function isPointInside(pPoint:Vector2D):Boolean {
            var ex:Number = _b.x - _a.x;
            var ey:Number = _b.y - _a.y;
            var fx:Number = _d.x - _a.x;
            var fy:Number = _d.y - _a.y;

            if ((pPoint.x - _a.x) * ex + (pPoint.y - _a.y) * ey < 0.0) return false;
            if ((pPoint.x - _b.x) * ex + (pPoint.y - _b.y) * ey > 0.0) return false;
            if ((pPoint.x - _a.x) * fx + (pPoint.y - _a.y) * fy < 0.0) return false;
            if ((pPoint.x - _d.x) * fx + (pPoint.y - _d.y) * fy > 0.0) return false;

            return true;
        };

        public function poolPrepare():void {
            _a.zero();
            _b.zero();
            _c.zero();
            _d.zero();
        };

        public function dispose():void {
            _pool.put(_a);
            _pool.put(_b);
            _pool.put(_c);
            _pool.put(_d);

            _a = null;
            _b = null;
            _c = null;
            _d = null;
        };

        public function toString():String {
            return '[ TQuad a= ' + _a + ', b=' + _b + ', c=' + _c + ', d=' + _d + ']';
        };
    }
}
