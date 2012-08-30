*Xtreams-Substreams-private
streamingReadMatching: aStream inclusive: tail
	"Return a stream that produces substreams that separate by @pattern and include the pattern in the result if @tail is true.
	 It uses the Knuth-Morris-Pratt algorithm, from Cormen et al.'s Algorithms, page 871. See also Gusfield's Alorithms on Strings, Trees and Sequences, page 23. This algorithm has the advantage in stream matching that it reads every character in the the text to be matched against exactly once, and never backtracks."

	| backtrack |
	backtrack := self streamingMatchPrefixFunction.
	^XTMatchReadSubstream on: aStream pattern: self backtrack: backtrack inclusive: tail