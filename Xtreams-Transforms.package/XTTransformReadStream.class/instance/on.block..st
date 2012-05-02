initialize-release
on: aReadStream block: aBlock
	
	self on: aReadStream.
	block := aBlock.
	closeBlock := [ :sourceStream | sourceStream close].
	sourceAtEnd := false.
	buffer := XTElasticBuffer new: DefaultBufferSize class: aReadStream contentsSpecies.
	bufferWriting := buffer writing