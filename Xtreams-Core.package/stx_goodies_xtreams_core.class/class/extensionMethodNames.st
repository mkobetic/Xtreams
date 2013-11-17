"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - contents
"
extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
        Object streamingInsert:into:
        Object streamingInsertInto:
        Object streamingPrintOn:
        Object streamingWrite:into:
        Object streamingWriteInto:
        SequenceableCollection streamingInsert:into:
        SequenceableCollection streamingInsertInto:
        SequenceableCollection streamingWrite:into:
        SequenceableCollection streamingWriteInto:
    )
