"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: transforming
"
monitoring: aNotificationBlock every: aNotificationInterval
	"Monitor the through-put of the receiver."
	"	aNotificationBlock <BlockClosure>	the block to execute when notifying
		aNotificationInterval <Duration>	how often to notify
		^<PositionWriteSubstream>
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
