"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: line-end
"
setLineEndAuto

        OperatingSystem isMSWINDOWSlike
                ifTrue:         [self setLineEndCRLF]
                ifFalse:        [self setLineEndLF]
