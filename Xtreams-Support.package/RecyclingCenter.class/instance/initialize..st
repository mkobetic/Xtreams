"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
initialize: aCacheLimit
	mutex := Semaphore forMutualExclusion.
	recycled := IdentityDictionary new.
	SequenceableCollection allSubclassesDo: [:aClass | recycled at: aClass put: (Array new: aCacheLimit)].
	recycled at: InterpretedBytes put: (Array new: aCacheLimit)
