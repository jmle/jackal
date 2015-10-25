package ;

class Util {

	/**
	* Returns an iterator over the unique values of the given array.
	*/
	public static function unique(a:Array<Int>):Iterator<Int> {
		var uniqueValues:Map<Int, Int> = new Map<Int, Int>();

		for (v in a) {
			uniqueValues.set(v, 1);
		}

		return uniqueValues.keys();
	}

}
