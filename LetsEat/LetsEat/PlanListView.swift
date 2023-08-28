//
//  PlanListView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct Plan: Hashable {
    var name: String
    var startDate: Date
    var endDate: Date
}

struct PlanListView: View {
    var dummyData: [Plan] =
    [Plan(name: "조단현",
          startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1)) ?? Date.now,
          endDate: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 1)) ?? Date.now),
     Plan(name: "이현재",
          startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1)) ?? Date.now,
          endDate: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1)) ?? Date.now),
     Plan(name: "이호수",
          startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1)) ?? Date.now,
          endDate: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 30)) ?? Date.now),
     Plan(name: "이현민",
          startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1)) ?? Date.now,
          endDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 1)) ?? Date.now),
     Plan(name: "김성민",
          startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1)) ?? Date.now,
          endDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 10)) ?? Date.now),
     Plan(name: "서은서",
          startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1)) ?? Date.now,
          endDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 30)) ?? Date.now),
     Plan(name: "송정현",
          startDate: Calendar.current.date(from: DateComponents(year: 2023, month: 6, day: 1)) ?? Date.now,
          endDate: Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 25)) ?? Date.now)]
    var body: some View {
        Form {
            ForEach(dummyData, id: \.self) {
                data in
                
                HStack {
                    Image("discord")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .padding()
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text(data.name)
                            .font(.system(size: 23))
                        
                        Text("약속까지 \(calcDate(from: data.endDate))일 남았습니다.")
                            .font(.system(.caption2))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Spacer()
                }
                .listRowSeparator(.hidden)
            }
        }
        .scrollContentBackground(.hidden)
    }
    
    func calcDate(from endDate: Date) -> Int {
        let Comp = Calendar.current.dateComponents([.day], from: Date(), to: endDate)
        guard let d = Comp.day else { return 0 }
        return d
    }

}

struct PlanListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListView()
    }
}
