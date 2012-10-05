initialize-release
on: aDestination
	buffer := XTBuffer new: DefaultBufferSize class: aDestination contentsSpecies.
	super on: aDestination