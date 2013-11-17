"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
on: aReadStream block: aBlock
	
	self on: aReadStream.
	block := aBlock.
	closeBlock := [ :sourceStream | sourceStream close].
	sourceAtEnd := false.
	buffer := ElasticBuffer new: DefaultBufferSize class: aReadStream contentsSpecies.
	bufferWriting := buffer writing
