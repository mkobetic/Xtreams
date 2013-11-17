"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: reading - complex
"
get: reading namespace: aClass
	<reads: 'Kernel.NameSpace'>

	^(self get: reading string: String) asStrictReference value
