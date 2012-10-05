initialize-release
tearDown

	input ifNotNil: [:f | f close].
	output ifNotNil: [:f | f close].
	[FileDirectory default deleteFileNamed: file pathParts last] ifError: []