"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - contents
"
extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        #'Xtreams::ReadStream' collecting:
        #'Xtreams::ReadStream' depairing
        #'Xtreams::ReadStream' doing:
        #'Xtreams::ReadStream' duplicating:
        #'Xtreams::ReadStream' encoding:
        #'Xtreams::ReadStream' encodingBase64
        #'Xtreams::ReadStream' encodingHex
        #'Xtreams::ReadStream' injecting:into:
        #'Xtreams::ReadStream' interpreting:
        #'Xtreams::ReadStream' interpreting:cacheSize:
        #'Xtreams::ReadStream' interpreting:size:
        #'Xtreams::ReadStream' interpreting:size:cacheSize:
        #'Xtreams::ReadStream' marshaling
        #'Xtreams::ReadStream' marshaling:
        #'Xtreams::ReadStream' monitoring:every:
        #'Xtreams::ReadStream' pairing
        #'Xtreams::ReadStream' rejecting:
        #'Xtreams::ReadStream' selecting:
        #'Xtreams::ReadStream' transforming:
        #'Xtreams::WriteStream' collecting:
        #'Xtreams::WriteStream' depairing
        #'Xtreams::WriteStream' doing:
        #'Xtreams::WriteStream' duplicating:
        #'Xtreams::WriteStream' encoding:
        #'Xtreams::WriteStream' encodingBase64
        #'Xtreams::WriteStream' encodingHex
        #'Xtreams::WriteStream' injecting:into:
        #'Xtreams::WriteStream' interpreting:
        #'Xtreams::WriteStream' interpreting:cacheSize:
        #'Xtreams::WriteStream' interpreting:size:
        #'Xtreams::WriteStream' interpreting:size:cacheSize:
        #'Xtreams::WriteStream' marshaling
        #'Xtreams::WriteStream' marshaling:
        #'Xtreams::WriteStream' monitoring:every:
        #'Xtreams::WriteStream' pairing
        #'Xtreams::WriteStream' rejecting:
        #'Xtreams::WriteStream' selecting:
        #'Xtreams::WriteStream' transforming:
        #'Xtreams::ReadStream' positioning
        #'Xtreams::WriteStream' buffering:
        #'Xtreams::WriteStream' positioning
    )
