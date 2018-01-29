/*
    test-state.swift

    Copyright (c) 2018 Stephen Whittle  All rights reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
*/

import Foundation
import SignalTrap

var count = 0
var started: TimeInterval = 0
let signalToSend = Signal.TERM

do {
    print("signal: \(signalToSend), state: \(signalToSend.state)")

    try ignore(signal: signalToSend)

    print("signal: \(signalToSend), state: \(signalToSend.state)")

    try restore(signal: signalToSend)

    print("signal: \(signalToSend), state: \(signalToSend.state)")

    try trap(signal: signalToSend) { signal in
        print("received signal: \(Signal(rawValue: signal).description)")

        exit(EXIT_SUCCESS)
    }

    print("signal: \(signalToSend), state: \(signalToSend.state)")

    print("sending signal : \(signalToSend.enumDescription)/\(signalToSend.enumOSDescription)/#\(signalToSend.number)")
    try raise(signal: signalToSend)
} catch let error as SignalTrapError {
    print(error)
} catch {
    print("an unexpected error '\(error)' has occured in the library libSignalTrap.")
}

exit(EXIT_FAILURE)
