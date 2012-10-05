Write stream on a sequenceable collection. The collection is grown automatically to accommodate any elements written. Closing a collection write stream will truncate the collection to the current stream position. This behavior is useful as a replacement for the traditional #contents message. The contents can be accessed with the #terminal message after the stream is closed. Sequenceable collections can also seek past the end of their contents, or sparse writing.
{{{
	String new writing write: 'Hello World'; -- 6; close; terminal
}}}

Instance Variables
	position	<Integer> current position of the stream
	length	<Integer> number of valid elements in the destination
