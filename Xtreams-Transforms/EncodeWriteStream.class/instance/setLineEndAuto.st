"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: line-end
"
setLineEndAuto

        OperatingSystem isMSWINDOWSlike
                ifTrue:         [self setLineEndCRLF]
                ifFalse:        [self setLineEndLF]
