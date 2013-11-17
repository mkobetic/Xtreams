"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
on: aStreamable block: aBlock
	super on: aStreamable.
	block := aBlock.
	incompleteCount := nil.
	closeBlock := [ :destinationStream | destinationStream close].
	buffer := ElasticBuffer new: DefaultBufferSize class: aStreamable contentsSpecies.
	self drainBuffer
