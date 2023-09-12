//
//  GenerateNicknameView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/11.
//

import SwiftUI

struct GenerateNicknameView: View {
    @State private var input: String = ""
    @State private var isOK: Bool = false
    @State private var showAlert = false
    var nicknameGenerated: () -> Void
    let regex = "^[^\\s]+$"
    
    var body: some View {
        NavigationStack {
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
                            .onChange(of: input) { newValue in
                                isOK = newValue.range(of: regex, options: .regularExpression) != nil
                            }
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                input = ""
                            }
                    }
                    
                    VStack(alignment: .trailing) {
                        if isOK {
                            Text("사용가능한 닉네임입니다.")
                                .foregroundColor(.green)
                        } else {
                            Text("사용불가한 닉네임입니다.")
                                .foregroundColor(.red)
                        }
                    }
                    Spacer()
                    Spacer()
                }
                .frame(width: 300)
                .padding()
                Button {
                    if isOK {
                        let nickname = input
                        signUp("", nickname)
                        nicknameGenerated()
                    } else {
                        showAlert = true
                        
                    }
                    
                } label: {
                    Text("complete")
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("닉네임이 올바르지 않습니다!"),
                        dismissButton: .default(Text("확인")))
                    
                }
            }
        }
        
    }
    
    private func signUp(_ deviceId: String, _ nickname: String) {
        //닉네임을 생성하고 디바이스 아이디와 함께 signUp요청
        //유저 아이디를 받아옴 -> signUp성공과 동시에 로그인 성공
        // let nickName = generateNickname()
        // apiSignUp(nickName, deviceId)
        // 이미 유저 아이디가 있는데 받는 이유?.. 로그인 성공시 어떻게 해야되는지(저장된 데이터들을 가져옴?)
    }
}

struct GenerateNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateNicknameView(nicknameGenerated: {})
    }
}
