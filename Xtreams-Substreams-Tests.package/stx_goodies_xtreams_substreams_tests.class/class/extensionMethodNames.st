"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - contents
"
extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
	#'Xtreams::FiniteReadingWritingTests' testReadClosing
	#'Xtreams::FiniteReadingWritingTests' testReadEndingBlock
	#'Xtreams::FiniteReadingWritingTests' testReadEndingBlockPositioning
	#'Xtreams::FiniteReadingWritingTests' testReadEndingBlockTail
	#'Xtreams::FiniteReadingWritingTests' testReadEndingCollection
	#'Xtreams::FiniteReadingWritingTests' testReadEndingCollectionPositioning
	#'Xtreams::FiniteReadingWritingTests' testReadEndingCollectionTail
	#'Xtreams::FiniteReadingWritingTests' testReadEndingObject
	#'Xtreams::FiniteReadingWritingTests' testReadEndingObjectPositioning
	#'Xtreams::FiniteReadingWritingTests' testReadEndingObjectTail
	#'Xtreams::FiniteReadingWritingTests' testReadLimiting
	#'Xtreams::FiniteReadingWritingTests' testReadLimitingPositioning
	#'Xtreams::FiniteReadingWritingTests' testReadStitchLimiting
	#'Xtreams::FiniteReadingWritingTests' testReadStitchingChunks
	#'Xtreams::FiniteReadingWritingTests' testWriteClosing
	#'Xtreams::FiniteReadingWritingTests' testWriteClosingPositioning
	#'Xtreams::FiniteReadingWritingTests' testWriteEndingBlock
	#'Xtreams::FiniteReadingWritingTests' testWriteEndingBlockTail
	#'Xtreams::FiniteReadingWritingTests' testWriteEndingCollection
	#'Xtreams::FiniteReadingWritingTests' testWriteEndingCollectionTail
	#'Xtreams::FiniteReadingWritingTests' testWriteEndingObject
	#'Xtreams::FiniteReadingWritingTests' testWriteEndingObjectTail
	#'Xtreams::FiniteReadingWritingTests' testWriteLimiting
	#'Xtreams::FiniteReadingWritingTests' testWriteLimitingPositioning
	#'Xtreams::FiniteReadingWritingTests' testWriteStitchLimiting
	#'Xtreams::FiniteReadingWritingTests' testWriteStitchingChunks
    )
