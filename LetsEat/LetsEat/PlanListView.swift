//
//  PlanListView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

extension Date {
    func calcDate(from endDate: Date) -> Int {
        let Comp = Calendar.current.dateComponents([.day], from: Date(), to: endDate)
        guard let d = Comp.day else { return 0 }
        return d
    }
    
//    func dateString() -> DateFormatter {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yy년 mm월 dd일"
//        dateFormatter.timeZone = .current
//        
//        return dateFormatter
//    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY년 MM월 dd일"
        return formatter
    }
}

struct Plan: Hashable {
    var name: String
    var startDate: Date
    var endDate: Date
}

struct PlanListView: View {
    @State var dataManager = DataManager.shared
    
    var body: some View {
        Form {
            ForEach(dataManager.getPlanDummyData(), id: \.self) {
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
                        Text("약속까지 \(Date().calcDate(from: data.endDate))일 남았습니다.")
                            .font(.system(.caption2))
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Spacer()
                    
                    stingButton()
                        .padding()
                        
//                    extendButton()
                    
                }
                .listRowSeparator(.hidden)
            }

        }
        .scrollContentBackground(.hidden)
    }
}

struct stingButton: View {
    @State private var isSting: Bool = false
    
    var body: some View {
        Button {
            isSting.toggle()
        } label: {
            Text("찌르기")
                .font(.system(.caption))
                .foregroundColor(.primary)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 10))
        .alert("test", isPresented: $isSting) {
            Button("네") {
                sendMessage()
            }
            Button("아니오", role: .cancel) {
                
            }
        } message: {
            Text("찌르겠습니까?")
        }
    }
    
    func sendMessage() {
        print("send Message!")
    }
}

struct extendButton: View {
    var body: some View {
        Button {
            
        } label: {
            Text("연장하기")
                .font(.system(.caption))
                .foregroundColor(.primary)
        }
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle(radius: 10))
    }
}

struct PlanListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListView()
    }
}
