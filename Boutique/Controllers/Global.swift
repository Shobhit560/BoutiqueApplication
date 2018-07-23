//
//  Global.swift
//  Boutique
//
//  Created by Shobhit Saxena on 04/07/18.
//  Copyright © 2018 Shobhit Saxena. All rights reserved.
//
import UIKit

let ACCEPTABLE_CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-"
let ACCEPTED_DIGITS_ONLY = "0123456789"

class Global: NSObject {

}

extension Date {
    
    private static let dateFormatterUTC: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss ZZZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    private static let dateFormatterddMMyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm:ss ZZZ"
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        return formatter
    }()
    
    private static let dateFormatterdd_MM_yyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        formatter.timeZone = NSTimeZone.local  //TimeZone(abbreviation: "UTC")
        return formatter
    }()

//    01-April-2017
    private static let dateFormatterdd_MMMM_yyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    private static let dateFormatterdd_yyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    // May 28
    private static let dateFormatterdd_MMM_dd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    //    MMM yyyy
    private static let dateFormatterdd_MMM_yyyy: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    private static let dateFormatterDD_MMM_YYYY: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    private static let dateFormatter_dd_MM_yyyy_HH_mm_a:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy HH:mm a"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    private static let dateFormatter_dd_MMMM_yyyy_HH_mm_a:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy HH:mm a"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    private static let dateFormatter_dd_MMMM_yyyy_HH_mm:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMMM-yyyy HH:mm"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    private static let dateformatter_dd_MMM_yyyy_HH_mm_ss:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy 00:00:00"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    private static let dateFormatter_dd_MMM_yyyy_HH_mm_ss:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    private static let dateFormatter_dd_MMM_yyyy_HH_mm:DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    private static let dateFormatter_yyyy_MM_dd_T_HH_mm_ss_SSS:DateFormatter = {
        let formatter = DateFormatter()
        //"2018-02-24T19:58:56.303"
        formatter.dateFormat = "yyyy-MM-ddTHH:mm:ss.SSS"
        formatter.timeZone = NSTimeZone.local
        return formatter
    }()
    
    public var dd_MMMM_yyy : String {
        return Date.dateFormatterdd_MMMM_yyy.string(from: self)
    }
    public var yyyy : String {
        return Date.dateFormatterdd_yyyy.string(from: self)
    }
    public var MMM_dd : String {
        return Date.dateFormatterdd_MMM_dd.string(from: self)
    }
    

    public var ddMMyyyy : String {
        return Date.dateFormatterddMMyyy.string(from: self)
    }
    
    public var UTC : String {
        return Date.dateFormatterUTC.string(from: self)
    }
    
    public var MMM_yyyy : String {
        return Date.dateFormatterdd_MMM_yyyy.string(from: self)
    }
    public var DD_MM_yyyy_HH_mm_a : String {
        return Date.dateFormatter_dd_MM_yyyy_HH_mm_a.string(from: self)
    }
    public var DD_MMM_yyyy_HH_mm_ss : String {
        return Date.dateFormatter_dd_MMM_yyyy_HH_mm_ss.string(from: self)
    }
    public var dd_MMM_yyyy_HH_mm_ss:String {
        return Date.dateformatter_dd_MMM_yyyy_HH_mm_ss.string(from: self)
    }
    public var DD_MMM_YYYY:String {
        return Date.dateFormatterDD_MMM_YYYY.string(from: self)
    }
    public var dd_MMM_yyyy_HH_mm:String {
        return Date.dateFormatter_dd_MMM_yyyy_HH_mm.string(from: self)
    }
    
    
    
    //    dateFormatterdd_MM_yyy
    public var DD_MM_yyyy : String {
        return Date.dateFormatterdd_MM_yyy.string(from: self)
    }
    
    
    public var DD_MMMM_yyyy_HH_mm_a : String {
        return Date.dateFormatter_dd_MMMM_yyyy_HH_mm_a.string(from: self)
    }
    
    public var DD_MMMM_yyyy_HH_mm : String {
        return Date.dateFormatter_dd_MMMM_yyyy_HH_mm.string(from: self)
    }
    public var yyyy_MM_dd_T_HH_mm_ss_SSS : String {
        return Date.dateFormatter_yyyy_MM_dd_T_HH_mm_ss_SSS.string(from: self)
    }
    
    func startOfMonth() -> Date? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MM yyyy HH:mm:ss ZZZ"
        dateFormatter.timeZone = NSTimeZone.local
        //        (abbreviation: "GMT-5:00") as TimeZone!
        let string = dateFormatter.string(from: self)
        
        let presentDate = dateFormatter.date(from: string)
        
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month, .weekday], from: presentDate!)
        let startOfMonth = calendar.date(from: currentDateComponents)
        
        return startOfMonth
    }
    
    func firstWeekDay() -> Int? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MM yyyy HH:mm:ss ZZZ"
        dateFormatter.timeZone = NSTimeZone.local
        //        (abbreviation: "GMT-5:00") as TimeZone!
        let string = dateFormatter.string(from: self)
        
        let presentDate = dateFormatter.date(from: string)
        
        let calendar = Calendar.current
        let currentDateComponents = calendar.dateComponents([.year, .month, .weekday], from: presentDate!)
        let startOfMonth = calendar.date(from: currentDateComponents)
        let weekday = Calendar.current.component(.weekday, from: startOfMonth!)
        
        return weekday
    }
    
    func dateByAddingMonths(_ monthsToAdd: Int) -> Date? {
        
        let calendar = Calendar.current
        var months = DateComponents()
        months.month = monthsToAdd
        
        return calendar.date(byAdding: months, to: self)
    }
    
    func convertStringToDate(strDate:String)->Date?
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yyyy" //Your date format
        let date = dateFormatter.date(from: strDate) //according to date format your date string
        return date
    }
    func convertStringIntoDate(strDate:String)->Date?{
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        let date = formatter.date(from: strDate)
        return date
    }
    
    func endOfMonthDate() -> Date? {
        
        guard let plusOneMonthDate = dateByAddingMonths(1) else { return nil }
        let calendar = Calendar.current
        let plusOneMonthDateComponents = calendar.dateComponents([.year, .month], from: plusOneMonthDate)
        let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
        
        return endOfMonth
    }
    
    func endOfMonth() -> Int? {
        
        guard let plusOneMonthDate = dateByAddingMonths(1) else { return nil }
        let calendar = Calendar.current
        let plusOneMonthDateComponents = calendar.dateComponents([.year, .month], from: plusOneMonthDate)
        let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = NSTimeZone.local
        
        let dayString = dateFormatter.string(from: endOfMonth!)
        return Int(dayString)
    }
    
    func current_previousEndOfMonth() -> (Int?, Int?)? {
        
        guard let plusOneMonthDate = dateByAddingMonths(1) else { return nil }
        let calendar = Calendar.current
        let plusOneMonthDateComponents = calendar.dateComponents([.year, .month], from: plusOneMonthDate)
        let endOfMonth = calendar.date(from: plusOneMonthDateComponents)?.addingTimeInterval(-1)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = NSTimeZone.local
        let dayString = dateFormatter.string(from: endOfMonth!)
        guard let previousplusOneMonthDate = dateByAddingMonths(0) else { return nil }
        let previousPlusOneMonthDateComponents = calendar.dateComponents([.year, .month], from: previousplusOneMonthDate)
        let previousEndOfMonth = calendar.date(from: previousPlusOneMonthDateComponents)?.addingTimeInterval(-1)
        
        let previousDayString = dateFormatter.string(from: previousEndOfMonth!)
        return (Int(dayString), Int(previousDayString))
    }
    
    func startOfWeek(value : Int) -> Date {
        let dateToFindWeek = Calendar.current.date(byAdding: .day, value: value, to: self)
        let date = Calendar.current.date(from: Calendar.current.dateComponents([.yearForWeekOfYear, .weekOfYear], from: dateToFindWeek!))!
        let dslTimeOffset = NSTimeZone.local.daylightSavingTimeOffset(for: date)
        return date.addingTimeInterval(dslTimeOffset)
    }
    
    func endOfWeek(value : Int) -> Date {
        return Calendar.current.date(byAdding: .second, value: 604799, to: self.startOfWeek(value : value))!
    }
}


