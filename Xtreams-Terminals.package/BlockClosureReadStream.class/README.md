Read stream on a zero argument block, evaluates the block once for each requested element, the result of the block evaluation is the element.
{{{
	"inifinite stream of ones"
	[ 1 ] reading read: 20
}}}
{{{
	"Fibonacci"
	| a b | a := 0. b := 1.
	[ | x | x := a. a := b. b := x + a. x ] reading ++ 500; get
}}}
{{{
	"Streaming over ObjectMemory"
	x := ObjectMemory someObject.
	[ x := ObjectMemory nextObjectAfter: x ] reading read: 5
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream
	closeBlock	<BlockClosure> invoked in response to the #close message, allows customizing the close behavior

