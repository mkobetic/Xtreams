"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: transforming
"
injecting: initialObject into: aBlock
	"Accumulates a running value combined with each passing element using the binary aBlock. aBlock takes the result of the last evaluation and the next element as arguments. Notable difference from the collection analog is that the streaming variant is a stream of all the intermediate values of the running value."
	"	initialObject	<Object> initial value used as the previous result for the evaluation of the first element
		aBlock	<BlockClosure> binary block combining the value of each element with previous result of its evaluation
		^<CollectingWriteStream>"
	"
		(Array new writing injecting: 0 into: [ :total :each | each + total ]) write: (1 to: 10); conclusion
	"
	| nextObject |
	nextObject := initialObject.
	^self collecting: [:each | nextObject := aBlock cull: nextObject cull: each]
