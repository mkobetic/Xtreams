initialize-release
initialize1: aCacheLimit
	mutex := Semaphore forMutualExclusion.
	recycled := IdentityDictionary new.
	SequenceableCollection allSubclassesDo: [:aClass | recycled at: aClass put: (Array new: aCacheLimit)]