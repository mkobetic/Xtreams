"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: seeking
"
-= anInteger

	anInteger isZero ifFalse: [^super -= anInteger].
	[outputBuffer hasDataToRead or: [substreamAtEnd not]] whileTrue:
		[outputBuffer hasDataToRead ifFalse: [self gobble].
		outputBuffer readSkip: outputBuffer readSize].
	^0