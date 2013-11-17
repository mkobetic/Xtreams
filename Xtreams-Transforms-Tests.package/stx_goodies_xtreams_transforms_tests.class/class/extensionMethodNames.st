"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - contents
"
extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        #'Xtreams::CollectionReadingWritingTest' testReadRejecting
        #'Xtreams::CollectionReadingWritingTest' testReadSelecting
        #'Xtreams::CollectionReadingWritingTest' testWriteRejecting
        #'Xtreams::CollectionReadingWritingTest' testWriteSelecting
        #'Xtreams::CollectionReadingWritingTest' testWriteTransformHexToByte
        #'Xtreams::FiniteReadingWritingTests' testInterpretingDoubles
        #'Xtreams::FiniteReadingWritingTests' testWriteTransformingOverLimitingPastEnd
        #'Xtreams::FiniteReadingWritingTests' testWriteTransformingPastEnd
        #'Xtreams::ReadingWritingTest' testCharacters
        #'Xtreams::ReadingWritingTest' testDoing
        #'Xtreams::ReadingWritingTest' testInterpretingPoints
        #'Xtreams::ReadingWritingTest' testReadCollecting
        #'Xtreams::ReadingWritingTest' testReadCollectingContentsSpeciesChanged
        #'Xtreams::ReadingWritingTest' testReadDecodingBase64
        #'Xtreams::ReadingWritingTest' testReadDecodingCRLF
        #'Xtreams::ReadingWritingTest' testReadDecodingTransparent
        #'Xtreams::ReadingWritingTest' testReadDecodingUTF16
        #'Xtreams::ReadingWritingTest' testReadDecodingUTF8
        #'Xtreams::ReadingWritingTest' testReadDuplicating
        #'Xtreams::ReadingWritingTest' testReadInjecting
        #'Xtreams::ReadingWritingTest' testReadRejecting
        #'Xtreams::ReadingWritingTest' testReadSelecting
        #'Xtreams::ReadingWritingTest' testReadTransforming1into2
        #'Xtreams::ReadingWritingTest' testReadTransforming2into1
        #'Xtreams::ReadingWritingTest' testReadTransformingPastEnd
        #'Xtreams::ReadingWritingTest' testReadUnsignedShortEndianness
        #'Xtreams::ReadingWritingTest' testWriteCollecting
        #'Xtreams::ReadingWritingTest' testWriteCollectingIncompatibleContentSpecies
        #'Xtreams::ReadingWritingTest' testWriteCollectingMultipleBufferSize
        #'Xtreams::ReadingWritingTest' testWriteDuplicating
        #'Xtreams::ReadingWritingTest' testWriteEncodingBase64
        #'Xtreams::ReadingWritingTest' testWriteEncodingCRLF
        #'Xtreams::ReadingWritingTest' testWriteEncodingTransparent
        #'Xtreams::ReadingWritingTest' testWriteEncodingUTF16
        #'Xtreams::ReadingWritingTest' testWriteEncodingUTF8
        #'Xtreams::ReadingWritingTest' testWriteInjecting
        #'Xtreams::ReadingWritingTest' testWriteRejecting
        #'Xtreams::ReadingWritingTest' testWriteSelecting
        #'Xtreams::ReadingWritingTest' testWriteTransformHexToByte
        #'Xtreams::ReadingWritingTest' testWriteTransforming1into2
        #'Xtreams::ReadingWritingTest' testWriteTransforming2into1
        #'Xtreams::ReadingWritingTest' testWriteUnsignedShortEndianness
    )
