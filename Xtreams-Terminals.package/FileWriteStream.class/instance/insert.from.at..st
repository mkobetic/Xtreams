"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
insert: anInteger from: aSequenceableCollection at: startIndex
	^self shouldNotImplement.

	"While it might seem desireable to be able to insert in to a file, the reality is you can only do so if you can read and write to the file. if you can read and write to the file, the fileSize becomes indeterminate. The only reasonable way to insert in to a file is to memory map it and access it with a PointerWriteStream instead."
