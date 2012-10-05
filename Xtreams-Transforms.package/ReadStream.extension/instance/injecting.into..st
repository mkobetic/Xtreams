*Xtreams-Transforms-transforming
injecting: initialObject into: aBlock
	"Accumulates a running value combined with each passing element using the binary aBlock. aBlock takes the result of the last evaluation and the next element as its arguments. Notable difference from the collection analog is that the streaming variant is a stream of all the intermediate values of the running value."
	"	initialObject	<Object> initial value used as the previous result for the evaluation of the first element
		aBlock	<BlockClosure> binary block combining the value of each element with previous result of its evaluation
		^<CollectingReadStream>"
	"
		((1 to: 10) reading injecting: 0 into: [ :total :each | each + total ]) rest
	"
	| nextObject |
	nextObject := initialObject.
	^self collecting: [:each | nextObject := aBlock cull: nextObject cull: each]