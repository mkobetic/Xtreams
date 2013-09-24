"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

	| read requested start |
	"make sure anything pending in the output buffer is completely consumed"
	(read := self outputCopy: anInteger into: aSequenceableCollection at: startIndex) = anInteger ifTrue: [^anInteger].
	requested := anInteger - read.
	start := startIndex + read.

	[	"process everything in the input buffer"
		[ compression finished not and: [ unconsumedIn > 0 ] ] whileTrue: [
			compression update: unconsumedIn from: input into: output do: [ :in :out |
				(unconsumedIn := unconsumedIn - in) > 0 ifTrue: [
					input replaceFrom: 1 to: unconsumedIn with: input startingAt: in + 1 ].
				unconsumedOut := out.
				false "Do not continue" ].
			(read := self outputCopy: requested into: aSequenceableCollection at: start) = requested ifTrue: [^anInteger].
			requested := requested - read.
			start := start + read ].
		unconsumedIn > 0 ifTrue: [ "This means that compressed content finished before the end of the source stream,
			input has what we've consumed beyond the compressed content."
			(Incomplete on: aSequenceableCollection count: anInteger - requested at: startIndex) raise ].
		"both input and output should be completely exhausted at this point;
		we need to read more, but it's not clear how much since the input is compressed,
		so let's attempt to read a full buffer."
		sourceAtEnd ifFalse: [
			unconsumedIn := [ source read: input size into: input at: 1 ] on: Incomplete do: [ :ex | sourceAtEnd := true. ex count ] ].
		unconsumedIn isZero ifTrue: [
			"There's no more input, but there might be some final bits of output in the compression state."
			compression finishInto: output do: [ :out |
				unconsumedOut := out.
				(read := self outputCopy: requested into: aSequenceableCollection at: start) = requested ifTrue: [^anInteger].
				requested := requested - read.
				start := start + read.
				true ].
			compression finished ifFalse: [ self error: 'The deflate stream terminated prematurely' ].
			(Incomplete on: aSequenceableCollection count: anInteger - requested at: startIndex) raise  ].
	] repeat.
	^anInteger