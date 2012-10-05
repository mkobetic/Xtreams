initialize-release
initialize: aCacheLimit
	mutex := Semaphore forMutualExclusion.
	recycled := IdentityDictionary new.
	(SequenceableCollection allSubclasses select: [:e | e isBits])
		do: [:aClass | recycled at: aClass put: (Array new: aCacheLimit)]