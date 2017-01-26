package nmath {
    import flash.errors.IllegalOperationError;

    public final class Random {

        public function Random() {
            throw new IllegalOperationError("Random is static!");
        };

        public static function goldenRatio():Number {
            var results:Number = Math.random();
                results += 0.618033988749895;
                results %= 1;

            return results;
        };

        [Inline]
        public static function range(pMin:Number, pMax:Number):Number {
            return pMin + (Math.random() * (pMax - pMin));
        }

        [Inline]
        public static function vectorRange(pVector:Object):Number {
            return range(pVector[0], pVector[1]);
        }

        public static function probability(pPercents:Number):Boolean {
            return range(0, 100) < pPercents;
        };

        [Inline]
        public static function variation(pValue:Number, pVariation:Number):Number {
            return pValue + 2.0 * (Math.random() - 0.5) * pVariation;
        };

        public static function randomIndex(pContent:Object):int {
            return Math.round(Math.random() * (pContent.length - 1));
        };

        public static function arrayElement(pContent:Object):Object {
            return pContent[randomIndex(pContent)];
        };
    }
}