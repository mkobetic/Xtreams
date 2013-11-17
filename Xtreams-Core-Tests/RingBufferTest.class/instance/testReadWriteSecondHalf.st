"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testReadWriteSecondHalf
	" <--- SomeData ... ReadAt ... WriteAt/DataEnd DataStart ... SomeData ---> "

	output := 'wwww' copy.
	buffer write: 3 from: '123' at: 1.
	buffer read: 3 into: output at: 1.
	buffer write: 3 from: 'ABC' at: 1.
	buffer read: 2 into: output at: 1.
	output := 'wwww' copy.
	buffer read: 1 into: output at: 1.
	self assert: output = 'Cwww'.
	self assert: buffer readPosition = 4.
	self assert: buffer readSize = 0.
	self assert: buffer writePosition = 4.
	self assert: buffer writeSize = 4
