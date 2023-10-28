//
//  SetPlanView.swift
//  LetsEat

import SwiftUI

struct SetPlanView: View {
    @State var expirationDate: Date = Date()
    @State var status: String = ""
    
    var body: some View {
        ZStack {
            List {
                Section {
                    DatePicker(selection: $expirationDate, in: Date()..., displayedComponents: .date) {
                        Text("날짜를 선택해주세요")
                    }
                    .datePickerStyle(.graphical)
                    .padding()
                }
                
                Section {
                    Text("시작 : \(Date.now.dateFormat())")
                    Text("종료 : \(expirationDate.dateFormat() )")
                }
                
                CameraView()
            }
            
            Spacer()
            
            VStack(alignment: .center) {
                Spacer()
                NavigationLink {
                    QRCodeImageView(expirationDate: $expirationDate)
                } label: {
                    Text("약속 만들기")
                }
                .padding()
            }
        }
    }
}


struct MakePlanModalView_Previews: PreviewProvider {
    static var previews: some View {
        SetPlanView()
    }
}
