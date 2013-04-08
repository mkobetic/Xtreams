"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: api
"
marshal: writing object: object
	| storeString |
	storeString := object storeString.
	(writing encoding: encoding)
		setLineEndLF;
		print: storeString size + 1;
		cr;
		write: storeString;
		cr