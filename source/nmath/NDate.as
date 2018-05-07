package nmath {
    import mvcutils.errors.StaticError;

    public class NDate {
        public static const MILLISECOND:int = 1;
        public static const SECOND:int = MILLISECOND * 1000;
        public static const MINUTE:int = SECOND * 60;
        public static const HOURS:int = MINUTE * 60;
        public static const DAYS:int = HOURS * 24;

        public function NDate() {
            throw new StaticError();
        }
    }
}
