Write stream on a single argument block, the block is evaluated for each element written with the element assigned as the argument of the evaluation.
{{{
	"Transcript as an xtream"
	[ :x | Transcript nextPut: x ] writing write: 'Hello World!'
}}}
{{{
	"/dev/null"
	[ :x | ] writing write: 'Hello World!'
}}}

Instance Variables
	contentsSpecies	<Class> species for collections of elements of this stream
	closeBlock	<BlockClosure> invoked in response to the #close message, allows customizing the close behavior

