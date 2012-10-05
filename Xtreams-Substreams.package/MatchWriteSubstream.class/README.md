This is a substream bounded by a string pattern. The algorithm used doesn't need to peek or step back to detect the pattern, so it can be used on non-positionable streams.

Instance Variables
	substreamAtEnd	<Boolean> is this substream at end
	pattern	<String> the bounding pattern
	patternStart	<Integer> 
	inclusive	<Boolean> is the boundary part of the substream contents
	backtrack	<Array> backtracking table for pattern

