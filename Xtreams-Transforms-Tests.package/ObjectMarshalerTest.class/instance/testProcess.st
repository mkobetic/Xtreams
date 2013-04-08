"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testProcess
	"Warning: Do not insert a breakpoint in to this method as the breakpoint will marshal and pull in far too much information. Do not set through the method until after the process has been marshaled, otherwise the test runner will inject itself in to the process and that too can become marshaled. Instead, place a 'self halt' in to the test."

	| processA processB processC processAhash processBhash processChash status |

	status := Buffer new: 10 class: Array.
	Root.Smalltalk at: #status put: status.

	processA :=
		[(Root.Smalltalk at: #status) put: Kernel.Processor activeProcess identityHash printString, '+1'.
		Kernel.Processor activeProcess suspend.
		(Root.Smalltalk at: #status) put: Kernel.Processor activeProcess identityHash printString, '+2'] newProcess.
	processA priority: 100.
	processAhash := processA identityHash printString.

	marshaling put: processA.
	processA resume.
	self assert: status get = (processAhash, '+1').
	marshaling put: processA.
	processA resume.
	self assert: status get = (processAhash, '+2').

	self analyse.
	processB := marshaling get.	processBhash := processB identityHash printString.
	processC := marshaling get.	processChash := processC identityHash printString.

	processB resume.
	self assert: status get = (processBhash, '+1').
	processC resume.
	self assert: status get = (processChash, '+2').
	processB resume.
	self assert: status get = (processBhash, '+2').

	Root.Smalltalk removeKey: #status