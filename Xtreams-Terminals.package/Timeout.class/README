Signalled by external timeout read/write streams, when the read/write operation times out.
{{{
	pipe := OSSystemSupport concreteClass pipeAccessorClass openPair.
	[	(pipe first reading: 1 seconds) get
	] ensure: [ pipe do: #close ]
}}}