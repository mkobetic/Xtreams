"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: seeking
"
position: aPosition

	^([ source position: aPosition * elementSize ] on: Incomplete do: [ :ex | ex count ]) // elementSize
