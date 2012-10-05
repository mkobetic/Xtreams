initialize-release
on: aSource
	buffer := XTBuffer new: DefaultBufferSize class: aSource contentsSpecies.
	super on: aSource