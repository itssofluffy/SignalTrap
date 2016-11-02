/*
    Signal.swift

    Copyright (c) 2016 Stephen Whittle  All rights reserved.

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

#if os(Linux)
import Glibc

public enum Signal: CInt {
    case SIGHUP = 1
    case SIGINT = 2
    case SIGQUIT = 3
    case SIGILL = 4
    case SIGTRAP = 5
    case SIGABRT = 6
    case SIGBUS = 7
    case SIGFPE = 8
    case SIGKILL = 9
    case SIGUSR1 = 10
    case SIGSEGV = 11
    case SIGUSR2 = 12
    case SIGPIPE = 13
    case SIGALRM = 14
    case SIGTERM = 15
    case SIGSTKFLT = 16
    case SIGCHLD = 17
    case SIGCONT = 18
    case SIGSTOP = 19
    case SIGTSTP = 20
    case SIGTTIN = 21
    case SIGTTOU = 22
    case SIGURG = 23
    case SIGXCPU = 24
    case SIGXFSZ = 25
    case SIGVTALRM = 26
    case SIGPROF = 27
    case SIGWINCH = 28
    case SIGIO = 29
    case SIGPWR = 30
    case SIGSYS = 31
}

extension Signal: CustomStringConvertible {
    public var description: String {
        func signalCode() -> String {
            return " (#" + String(self.rawValue) + ")"
        }

        if let signalName = Optional(String(cString: strsignal(self.rawValue))) {
            return signalName + signalCode()
        }

        return signalCode()
    }
}
#endif
