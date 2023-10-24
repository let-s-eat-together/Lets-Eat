//
//  Date+ext.swift
//  LetsEat

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    func ymdFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
    
    func remainDays(for date: Date) -> Int? {
        let components = Calendar.current.dateComponents([.day],
                                                         from: Date(), to: date)
        return components.day
    }
    
    
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}

