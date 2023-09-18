//
//  MakePlanModalView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/29.
//

import SwiftUI
import CodeScanner

struct MakePlanView: View {
    @State var expirationDate: Date = Date()
    
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
                    Text("시작 : \(Date().dateFormatter.string(from: Date()))")
                    Text("종료 : \(Date().dateFormatter.string(from: expirationDate))")
                }
                
                                
                CameraView()
            }
            
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
        MakePlanView()
    }
}
