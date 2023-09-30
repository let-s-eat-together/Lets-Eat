//
//  StingButton.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/25.
//

import SwiftUI

struct StingButton: View {
    @State private var isSting: Bool = false
    var otherUserId: String
    var body: some View {
        Button {
            isSting.toggle()
        } label: {
            Image(systemName: "hand.point.left.fill")
                .foregroundColor(.primary)
        }
        .alert(isPresented: $isSting) { // 마지막 이름 나오는 버그 고치기
            Alert(title: Text("콕 찔러보기"),
                  message: Text("\(otherUserId)님을 콕 찌르시겠습니까?"),
                  primaryButton: Alert.Button.default(Text("네")) {
                sendMessage(to: otherUserId)
            },
            secondaryButton: Alert.Button.destructive(Text("아니요")))
        }
    }
    
    func sendMessage(to who: String) { // 실패시 에러처리
        print("send to \(who) 콕!")
    }
}

//#Preview {
//    StingButton(otherUserId: "test")
//}
