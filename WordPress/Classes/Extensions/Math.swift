extension Int {
    /**
     Rounds self to the nearest multiple of the given argument
     
     In case of a tie, it rounds to the multiple with the highest absolute value.
     That is, `-3.round(5)` rounds to `-5` and `3.round(5)` rounds to `5`
     
     - parameter divisor: a positive number that's a divisor of the result.
     - returns: an Int rounded to the nearest integer that's a multiple of the argument.
     */
    func round(divisor: UInt) -> Int {
        assert(divisor > 0)
        if self == 0 || divisor == 0 {
            return self;
        }
        let sign = self / abs(self)
        let divisor = Int(divisor)
        let half = divisor / 2
        return self + sign * (half - (abs(self) + half) % divisor)
    }
}
