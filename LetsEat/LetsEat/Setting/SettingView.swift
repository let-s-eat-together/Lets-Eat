//
//  MessageManager.swift
//  LetsEat

import SwiftUI
import Alamofire

struct SettingView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    @State var userManager = UserManager.shared
    
    @State private var isAlarmOn: Bool = false
    @State private var editedNickname: String = ""
    @State private var isEditingNickname: Bool = false
    @State private var isOut: Bool = false
    @State private var hasDelete: Bool = false
    
    var isNicknameValid: Bool {
        return editedNickname.count >= 1
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section {
                    HStack {
                        Image("discord")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.all, 15)
                            .clipShape(Circle())
                        
                        Text(userManager.getUser()?.username ?? "default")
                            .font(.title2)
                        
                        
                        //                        VStack(alignment: .leading) {
                        //                            if isEditingNickname {
                        //                                TextField("변경할 이름", text: $editedNickname)
                        //                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                        //                                    .frame(width: 160)
                        //                                    .onAppear {
                        //                                        editedNickname = userManager.userInfo.nickname
                        //                                    }
                        //                            } else {
                        //                                Text(userManager.userInfo.nickname)
                        //                                //                                Text(nickname)
                        //                                //                                    .font(.headline)
                        //                            }
                        //                        }
                        //                        Spacer()
                        //                        Button(action: {
                        //                            isEditingNickname.toggle()
                        //                            if !isEditingNickname {
                        //                                if isNicknameValid {
                        //                                    //                                    nickname = editedNickname
                        //                                }
                        //                            }
                        //                        }) {
                        //                            Text(isEditingNickname ? "완료" : "프로필 수정")
                        //                                .foregroundColor(.blue)
                        //                        }
                    }
                }
                
                Section {
                    NavigationLink("프로필 수정") {
                        EditProfileView()
                    }
                }
                
                Section {
                    Toggle(isOn: $isAlarmOn) {
                        Text("Push 알림")
                    }
                    Toggle(isOn: $isDarkModeOn) {
                        Text("다크 모드")
                    }
                    .onChange(of: isDarkModeOn) { newValue in
                        UIApplication.shared.windows.first?.rootViewController?.overrideUserInterfaceStyle = newValue ? .dark : .light
                    }
                }
                
                Section {
                    NavigationLink("이용약관") {
                        Text("이용약관")
                    }
                    NavigationLink("개인정보 처리 방침") {
                        Text("detail")
                    }
                    NavigationLink("버전 정보") {
                        Text("현재 버전 1.0.0")
                    }
                }
                
                Section {
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
                    Button {
                        hasDelete.toggle()
                    } label: {
                        Text("탈퇴하기")
                    }
                    .alert(isPresented: $hasDelete) {
                        Alert(title: Text("회원 탈퇴"),
                              message: Text("탈퇴 하시겠습니까?"),
                              primaryButton: Alert.Button.default(Text("네")) {
                            withDraw()
                            if !KeychainManager().deleteDeviceID() {
                                print("삭제 오류")
                            }
                            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                exit(0)
                            }
                        },
                        secondaryButton: Alert.Button.destructive(Text("아니요")))
                    }
                }
            }
        }
        .navigationTitle("설정")
    }
    
    func withDraw() {
        let url = "http://34.22.94.135:8080/withdraw"
        
        let params: Parameters = ["user_id": userManager.userInfo.id]
        
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        AF.request(url,
                   method: .put,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<600)
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case .success:
                print("탈퇴 완료")
            case .failure:
                print(response.error.debugDescription)
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}


