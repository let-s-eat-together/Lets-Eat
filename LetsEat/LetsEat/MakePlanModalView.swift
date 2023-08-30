//
//  MakePlanModalView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/29.
//

import SwiftUI

struct MakePlanModalView: View {
    @Binding var isPresented: Bool
    @State var planDate: Date = Date()
    
    var body: some View {
        Form {
            Section {
                DatePicker(selection: $planDate, in: Date()..., displayedComponents: .date) {
                    Text("날짜를 선택해주세요")
                }
                .padding()
            }
            Section {
                
                Text("시작 : \(Date().dateFormatter.string(from: Date()))")
                Text("종료 : \(Date().dateFormatter.string(from: planDate))")
            }
            Section {
                Button {
                    isPresented.toggle()
                    makePlan()
                } label: {
                    Text("약속 만들기")
                }
                .buttonStyle(.bordered)
                .buttonBorderShape(.roundedRectangle(radius: 10))
            }
        }
    }
    
    func makePlan() {
        
    }
}

struct MakePlanModalView_Previews: PreviewProvider {
    static var previews: some View {
        MakePlanModalView(isPresented: .constant(true))
    }
}
