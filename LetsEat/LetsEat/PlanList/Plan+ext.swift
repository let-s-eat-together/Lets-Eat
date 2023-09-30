//
//  Plan+ext.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/25.
//

import Foundation

extension Date {
    func calcDate(from endDate: Date) -> Int {
        let Comp = Calendar.current.dateComponents([.day], from: Date(), to: endDate)
        print(Comp)
        guard let d = Comp.day else { return 0 }
        return d
    }
    
    func dateFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy년 MM월 dd일"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}
