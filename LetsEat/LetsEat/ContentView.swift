//
//  ContentView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct ContentView: View {
    @State var isLoading: Bool = true
    @State var isLoginSuccess: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                PlanListView()
                    .scrollContentBackground(.hidden)
            }
            .zIndex(0)
            if isLoading {
                LaunchScreenView()
                    .transition(.opacity)
                    .zIndex(1)
            } else if !isLoginSuccess {
                GenerateNicknameView()
                    .zIndex(1)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    let deviceId = UIDevice.current.identifierForVendor!.uuidString
                    if login(deviceId) {
                        // login success
                        isLoginSuccess = true
                    } else {
                        signUp(deviceId)
                    }
                    isLoading.toggle()
                }
            })
        }
    }
    
    private func login(_ deviceId: String) -> Bool{
        //디바이스 아이디로 로그인 요청
        //있으면 유저 아이디 받아옴 -> 로그인 성공
        //없으면 -1을 받음 -> 로그인 실패, 닉네임 생성(signUp)
        var isFailApiLogin: Bool = false // true면 닉네임 생성, false면 로그인 성공
        if isFailApiLogin { // (apiLogin(deviceId)) == -1
            return false
        } else {
            // user id 받음.. 로그인 성공이므로 ... 로그인 성공시 어떻게 해야되는지(저장된 데이터들을 가져옴?)
            return true
        }
    }
    
    private func signUp(_ deviceId: String) {
        //닉네임을 생성하고 디바이스 아이디와 함께 signUp요청
        //유저 아이디를 받아옴 -> signUp성공과 동시에 로그인 성공
        // let nickName = generateNickname()
        // apiSignUp(nickName, deviceId)
        // 이미 유저 아이디가 있는데 받는 이유?.. 로그인 성공시 어떻게 해야되는지(저장된 데이터들을 가져옴?)
    }
}

struct GenerateNicknameView: View {
    @State private var input: String = ""
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Spacer()
                Text("닉네임")
                    .font(.callout)
                    .bold()
                ZStack(alignment: .trailing) {
                    TextField("닉네임을 입력해주세요...", text: $input)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            input = ""
                        }
                }
                VStack(alignment: .trailing) {
                    Text("사용가능한 닉네임입니다.")
                        .foregroundColor(.green)
                    Text("사용불가한 닉네임입니다.")
                        .foregroundColor(.red)
                }
                Spacer()
                Spacer()
            }
            .frame(width: 300)
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
