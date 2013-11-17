"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: substreaming
"
stitching
	^self error: 'You can only stitch a read stream, however that read stream can return write streams and in so doing, you will create a stitching write stream.'
