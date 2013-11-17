"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
on: aStreamable block: aBlock
	super on: aStreamable.
	block := aBlock.
	incompleteCount := nil.
	closeBlock := [ :destinationStream | destinationStream close].
	buffer := ElasticBuffer new: DefaultBufferSize class: aStreamable contentsSpecies.
	self drainBuffer
