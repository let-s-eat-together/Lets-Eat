//
//  MakePlanModalView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/29.
//

import SwiftUI

struct MakePlanView: View {
//    @Binding var isPresented: Bool
    @State var expirationDate: Date = Date()
    @State var isGenerated: Bool = false
    
    var body: some View {
        Form {
            Section {
                DatePicker(selection: $expirationDate, in: Date()..., displayedComponents: .date) {
                    Text("날짜를 선택해주세요")
                }
                .datePickerStyle(.graphical)
                .padding()
            }
            Section {
                
                Text("시작 : \(Date().dateFormatter.string(from: Date()))")
                Text("종료 : \(Date().dateFormatter.string(from: expirationDate))")
            }
            Button {
                //                isPresented.toggle()
                isGenerated.toggle()
                generateQRcode()
            } label: {
                Text("약속 만들기")
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .sheet(isPresented: $isGenerated) {
                QRCodeImageView(expirationDate: $expirationDate)
                
            }
        }
    }
    
    func generateQRcode() {
        
    }
}


struct MakePlanModalView_Previews: PreviewProvider {
    static var previews: some View {
        MakePlanView()
    }
}
