accessing
rest
	"Read all remaining elements from self."
	"	^		<SequenceableCollection>	a new collection of elements read from this stream
	"

	"Implementation note: Originally we sent #close then #destination, but sending #close will perform a #become:
		and our constructed write stream is going to go away as soon as we leave this method, so we're better off
		using #contents instead"

	^self contentsSpecies new writing
		write: self;
		contents