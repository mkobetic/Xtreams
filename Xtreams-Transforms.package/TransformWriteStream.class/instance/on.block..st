initialize-release
on: aStreamable block: aBlock
	super on: aStreamable.
	block := aBlock.
	incompleteCount := nil.
	closeBlock := [ :destinationStream | destinationStream close].
	buffer := XTElasticBuffer new: DefaultBufferSize class: aStreamable contentsSpecies.
	self drainBuffer