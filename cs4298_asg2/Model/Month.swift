import Foundation

// MARK: - Month
/**
 A simple enumeration representing a month in a year.
 */
public enum Month : Int {
    case January = 1, February, March, April, May, June, July, August, September, October, November, December
    
    /**
     Returns the name of the day given a specific locale. For example, for the `January` enum value,
     the en_AU locale would return "January" and fr_FR would return "janvier"
     
     - parameter The: locale to use. Defaults to user's current locale.
     - returns: The locale-specific representation of the month's name
     */
    public func displayName() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM"
        let date = formatter.date(from: "\(self.rawValue)")
        formatter.dateFormat = "MMMM"
        return formatter.string(from: date!)
    }
    
    /**
     Adds a number of months to the current month and returns the new month.
     
     - parameter The: number of months to add. May be negative, in which case it will be subtracted
     - returns: The new month
     */
    public func plus(months: Int) -> Month {
        // * Moving forward 3 months is the same as 15 months and 27 months, so we modulo 12
        //   to get the smallest number of equivalent months
        // * Moving backwards by 3 months is the same as going forward by 9 months, so we add
        //   12 to cater for negative numbers
        // * Ordinarily we could just add this value to the current month's rawValue and modulo
        //   12 to get the new month. However, modulo results in 0-based calcs and because our
        //   months are 1-based we need to subtract one before doing the modulo, do the modulo,
        //   and then add it back in. A bit tedious, but there you are.
        let normalized = months % 12
        return Month(rawValue: ((self.rawValue + normalized + 12 - 1) % 12) + 1)!
    }
    
    /**
     Subtracts a number of months from the current month and returns the new month.
     
     - parameter The: number of months to subtract. May be negative, in which case it will be added
     - returns: The new month
     */
    
}
