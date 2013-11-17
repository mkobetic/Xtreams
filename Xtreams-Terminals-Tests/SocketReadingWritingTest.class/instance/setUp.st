"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
setUp

        |listener|

        listener := Socket newTCP: 0.
        [   [   listener listenFor: 1.
                input := Socket newTCPclientToHost: #[127 0 0 1] port: listener port.
                output := listener accept
            ] ifCurtailed: [
                input notNil ifTrue: [ input close ].
                output notNil ifTrue: [ output close ] ].
        ] ensure: [ listener close ].
        input := input reading.
        output := output writing.
