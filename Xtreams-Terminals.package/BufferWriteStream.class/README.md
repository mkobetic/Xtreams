Write stream on a Buffer. Usually used in tandem with a read stream to access buffer contents conveniently.
{{{
	buffer := ElasticBuffer on: String new.
	bufferIn := buffer writing.
	bufferOut := buffer reading.
	100000 timesRepeat: [ bufferIn write: 'Hello World'. bufferOut read: 11 ].
	buffer cacheSize  
}}}
