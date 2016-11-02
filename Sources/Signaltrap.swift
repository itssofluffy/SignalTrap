/*
    Signaltrap.swift

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
            return " (#" + String(describing: self) + ")"
        }

        switch self {
            case .SIGHUP:
                return "Hangup" + signalCode()
            case .SIGINT:
                return "Terminal interrupt" + signalCode()
            case .SIGQUIT:
                return "Terminal quit" + signalCode()
            case .SIGILL:
                return "Illegal instruction" + signalCode()
            case .SIGTRAP:
                return "Trace trap" + signalCode()
            case .SIGABRT:
                return "IOT Trap" + signalCode()
            case .SIGBUS:
                return "BUS error" + signalCode()
            case .SIGFPE:
                return "Floating point exception" + signalCode()
            case .SIGKILL:
                return "Kill(can't be caught or ignored)" + signalCode()
            case .SIGUSR1:
                return "User defined signal 1" + signalCode()
            case .SIGSEGV:
                return "Invalid memory segment access" + signalCode()
            case .SIGUSR2:
                return "User defined signal 2" + signalCode()
            case .SIGPIPE:
                return "Write on a pipe with no reader, Broken pipe" + signalCode()
            case .SIGALRM:
                return "Alarm clock" + signalCode()
            case .SIGTERM:
                return "Termination" + signalCode()
            case .SIGSTKFLT:
                return "Stack fault" + signalCode()
            case .SIGCHLD:
                return "Child process has stopped or exited, changed" + signalCode()
            case .SIGCONT:
                return "Continue executing, if stopped" + signalCode()
            case .SIGSTOP:
                return "Stop executing(can't be caught or ignored)" + signalCode()
            case .SIGTSTP:
                return "Terminal stop signal" + signalCode()
            case .SIGTTIN:
                return "Background process trying to read, from TTY" + signalCode()
            case .SIGTTOU:
                return "Background process trying to write, to TTY" + signalCode()
            case .SIGURG:
                return "Urgent condition on socket" + signalCode()
            case .SIGXCPU:
                return "CPU limit exceeded" + signalCode()
            case .SIGXFSZ:
                return "File size limit exceeded" + signalCode()
            case .SIGVTALRM:
                return "Virtual alarm clock" + signalCode()
            case .SIGPROF:
                return "Profiling alarm clock" + signalCode()
            case .SIGWINCH:
                return "Window size change" + signalCode()
            case .SIGIO:
                return "I/O now possible" + signalCode()
            case .SIGPWR:
                return "Power failure restart" + signalCode()
            case .SIGSYS:
                return "SIGSYS" + signalCode()
        }
    }
}

public typealias SigactionHandler = @convention(c)(CInt) -> Void

public func trap(_ signum: Signal, action: SigactionHandler) {
    var sigAction = sigaction()

    sigAction.__sigaction_handler = unsafeBitCast(action, to: sigaction.__Unnamed_union___sigaction_handler.self)

    sigaction(signum.rawValue, &sigAction, nil)
}
