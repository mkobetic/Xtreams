Read stream on a one argument block, evaluates the block once for the life time of the stream. Once the block finishes execution, the stream is closed. The block is expected to write to the block argument, which will block exectuion until elements are read from the stream.
{{{
	"In this example, we have a -hard- loop, not using collection protocol, which will only run one element at a time."
	[:out | 1 to: 10 do: [:i | out put: i]] reading read: 5.
}}}
{{{
	"Fibonacci"
	[:out | | a b x |
	a := 0. b := 1.
	[out put: a.
	x := a.
	a := b.
	b := b + x] repeat] reading ++ 500; get.
}}}

Instance Variables
	current	<Object>	the current element in the stream
	closed	<Boolean>	true if the block has finished execution
	contentsSpecies	<Class>	species for collections of elements of this stream
	process	<Process>	the process executing the block
	readingSemaphore	<Semaphore>	attempts to read will wait on this
	writingSemaphore	<Semaphore>	attempts to write will wait on this, signaled when an attempt to read is performed

