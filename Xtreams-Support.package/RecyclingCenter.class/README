RecyclingCenter allows to recycle collection instances to lighten the load on the garbage collector. This is especially useful when large buffers are being allocated and thrown away in rapid sequence (e.g. when a server is handling a large number of short lived connections). By reusing instances we can save a lot of GC cycles.

Note however that it is critical to make sure that a recycled instance cannot be used before it is returned to the recycling pool (generally by making sure there are no references to it), otherwise an instance may end up being shared among unrelated objects. Similarly, #recycle must not be called more than once, otherwise it can be registered in the pool several times and it will end up being shared once two clients ask for a new instance of the same class. It is best to use the following pattern to recycle a 'cache' collection:

	| saved |
	saved := cache.
	cache := nil.
	saved == nil ifFalse: [ saved recycle ]

Instance Variables
	recycled	<IdentityDictionary key: Class value: (Array of: SequenceableCollection)> caches fixed number of collections (3) per sequenceable collection class
	mutex	<Semaphore> 

Class Instance Variables
	objectspace1	<RecyclingCenter> old space collections size 1
	fixedspace1	<RecyclingCenter> fixed space collections size 1
	objectspaceN	<RecyclingCenter> old space collections of cacheSize
	fixedspaceN	<RecyclingCenter> fixed space collection of cacheSize
	cacheSize	<SmallInteger> default collection size

