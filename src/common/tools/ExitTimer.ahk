InteractTimer := A_Now
InteractTimeout = 30
class ExitTimer {
    Call() {
        global InteractTimer, InteractTimeout
        if ( A_Now - InteractTimer >= InteractTimeout ) {
            ExitApp
        } else {
            Return true
        }
    }

    __Call(method, args*) {
        if (method = "")
            return this.Call(args*)
        if (IsObject(method))
            return this.Call(method, args*)
    }

}