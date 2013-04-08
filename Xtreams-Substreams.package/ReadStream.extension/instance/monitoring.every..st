"
notice: Copyright (c) 2010 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
monitoring: aNotificationBlock every: aNotificationInterval
	"Monitor the through-put of the receiver."
	"	aNotificationBlock <BlockClosure>	the block to execute when notifying
		aNotificationInterval <Duration>	how often to notify
		^<PositionReadSubstream>
	"

	"
		| monitor |
		monitor := ObjectMemory imageFilename reading
			monitoring: [:totalTransferred :deltaTransferred :elapsedMicroseconds |
				throughputSpeed := deltaTransferred.
				averageSpeed := (totalTransferred / elapsedMicroseconds) * 1000000.
				Transcript writing cr;
					write: 'average speed: '; print: averageSpeed asFloat;
					write: ' through-put speed: '; print: throughputSpeed asFloat;
					write: ' elapsed-time: '; print: elapsedMicroseconds / 1000000.0]
			every: 1 milliseconds.
		[monitor rest] ensure: [monitor close].
	"

	| previousPosition timer start notifyBlock monitoring notifyProcess notifyFinished |

	start := Time microsecondClock.
	previousPosition := 0.
	monitoring := nil.
	timer := nil.
	notifyFinished := false.

	notifyBlock := [
		aNotificationBlock cull: monitoring position cull: monitoring position - previousPosition cull: Time microsecondClock - start.
		previousPosition := monitoring position].

	notifyProcess := nil.
	notifyProcess := [
		[notifyBlock value. notifyFinished] whileFalse: [notifyProcess suspend]] newProcess.
	notifyProcess priority: ((Processor activeProcess priority + 1) min: 99).

	monitoring := self closing: [
		timer stop.
		notifyProcess resume.
		notifyFinished := true.
		notifyProcess resume.
		self close].

	timer := Timer every: aNotificationInterval resume: notifyProcess.
	^monitoring