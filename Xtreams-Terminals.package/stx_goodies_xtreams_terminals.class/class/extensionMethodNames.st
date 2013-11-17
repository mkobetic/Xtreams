"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description - contents
"
extensionMethodNames
    "lists the extension methods which are to be included in the project.
     Entries are 2-element array literals, consisting of class-name and selector."

    ^ #(
	Block reading
	Block writing
	Collection writing
	Filename appending
	Filename reading
	Filename writing
	Random reading
	SequenceableCollection reading
	SequenceableCollection writing
	SharedQueue reading
	SharedQueue writing
	Socket accepting
	Socket reading
	Socket writing
	UndefinedObject writing
	#'Xtreams::Buffer' reading
	#'Xtreams::Buffer' writing
	#'Xtreams::WriteStream' buffering:
	PipeStream isActive
	PipeStream reading
	PipeStream writing
	TextCollector writing
    )
