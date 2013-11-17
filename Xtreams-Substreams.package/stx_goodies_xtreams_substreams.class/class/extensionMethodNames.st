"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - contents
"
extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
	Block streamingReadMatching:inclusive:
	Block streamingWriteMatching:inclusive:
	Object streamingReadMatching:inclusive:
	Object streamingWriteMatching:inclusive:
	SequenceableCollection streamingMatchPrefixFunction
	SequenceableCollection streamingReadMatching:inclusive:
	SequenceableCollection streamingWriteMatching:inclusive:
	#'Xtreams::ReadStream' #','
	#'Xtreams::ReadStream' closing:
	#'Xtreams::ReadStream' ending:
	#'Xtreams::ReadStream' ending:inclusive:
	#'Xtreams::ReadStream' limiting:
	#'Xtreams::ReadStream' slicing
	#'Xtreams::ReadStream' stitching
	#'Xtreams::WriteStream' closing:
	#'Xtreams::WriteStream' ending:
	#'Xtreams::WriteStream' ending:inclusive:
	#'Xtreams::WriteStream' limiting:
	#'Xtreams::WriteStream' slicing
	#'Xtreams::WriteStream' stitching
    )
