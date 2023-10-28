//
//  LogOutButton.swift
//  LetsEat

import SwiftUI

struct LogOutButton: View {
    @Binding var isOut: Bool
    
    var body: some View {
        Button {
            isOut.toggle()
        } label: {
            Text("로그아웃")
        }
        .alert(isPresented: $isOut) {
            Alert(title: Text("나가기"),
                  message: Text("앱을 종료 하시겠습니까?"),
                  primaryButton: Alert.Button.default(Text("네")) {
                UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    exit(0)
                }
            },
                  secondaryButton: Alert.Button.destructive(Text("아니요")))
        }
    }
}
