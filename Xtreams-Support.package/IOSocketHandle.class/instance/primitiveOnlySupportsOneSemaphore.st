accessing
primitiveOnlySupportsOneSemaphore

	^ primitiveOnlySupportsOneSemaphore ifNil: [primitiveOnlySupportsOneSemaphore := false]
