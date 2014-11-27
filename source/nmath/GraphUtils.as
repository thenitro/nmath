package nmath {
    import flash.errors.IllegalOperationError;
    import flash.utils.Dictionary;

    import ncollections.grid.Grid;
    import ncollections.grid.IGridObject;

    public class GraphUtils {
		private static const EMPTY_ARRAY:Array = [];

		public function GraphUtils() {
			throw new IllegalOperationError('GraphUtils is static!');
		};
		
		public static function bfs(pIndexX:uint, pIndexY:uint,
								   pGrid:Grid, pAddHeighbors:Function,
                                   pComparator:Function):Array {
			var current:IGridObject;
			var searched:IGridObject = pGrid.take(pIndexX, pIndexY) as IGridObject;
			
			if (!searched) {
				return EMPTY_ARRAY;
			}
			
			var neighbors:Array = [];
			
			var seen:Dictionary = new Dictionary();

			var selected:Array = [];
			var queue:Array    = [];
				queue.push(searched);
			
			while (queue.length) {
				current = queue.shift();
				
				if (!current) {
					continue;
				}
				
				pAddHeighbors(pGrid, current.indexX, current.indexY, neighbors);
				
				for each (var neighbor:IGridObject in neighbors) {
					if (!neighbor) {
						continue;
					}
					
					if (seen[neighbor]) {
						continue;
					}
					
					seen[neighbor] = true;
					
					if (pComparator(neighbor, searched)) {
						selected.push(neighbor);
						queue.push(neighbor);
					} else {
						continue;
					}	
				}
				
				neighbors.length = 0;
			}
			
			return selected;
		};
		
		public static function addNeighborsHorizontal(pGrid:Grid, 
													  pIndexX:int, pIndexY:int, 
													  pContainer:Array):void {
			pContainer.push(pGrid.take(pIndexX - 1, pIndexY), pGrid.take(pIndexX + 1, pIndexY));
		};
		
		public static function addNeighborsVertical(pGrid:Grid, 
													pIndexX:int, pIndexY:int, 
													pContainer:Array):void {
			pContainer.push(pGrid.take(pIndexX, pIndexY - 1), pGrid.take(pIndexX, pIndexY + 1));
		};
		
		public static function addNeighborsVerticalHorizintal(pGrid:Grid, 
													pIndexX:int, pIndexY:int, 
													pContainer:Array):void {
			addNeighborsVertical(pGrid, pIndexX, pIndexY, pContainer);
			addNeighborsHorizontal(pGrid, pIndexX, pIndexY, pContainer);
		};

        public static function reflectionComparator(pNeighbor:IGridObject,
                                                    pSearched:IGridObject):Boolean {
            return pNeighbor.reflection == pSearched.reflection;
        };
	};
}