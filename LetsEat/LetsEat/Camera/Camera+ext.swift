//
//  Camera+ext.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/25.
//

import Foundation

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}