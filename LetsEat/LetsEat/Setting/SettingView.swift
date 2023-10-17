//
//  MessageManager.swift
//  LetsEat

import SwiftUI

struct SettingView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    @State var userManager = UserManager.shared
    
    @State private var isAlarmOn: Bool = false
    @State private var editedNickname: String = ""
    @State private var isEditingNickname: Bool = false
    
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
                    NavigationLink("개인정보 처리 방칭") {
                        Text("detail")
                    }
                    NavigationLink("버전 정보") {
                        Text("현재 버전 1.0.0")
                    }
                }
                
                Section {
                    Button {
                        
                    } label: {
                        Text("로그아웃")
                    }
                    Button {
                        if !KeychainManager().deleteDeviceID() {
                            print("삭제 오류")
                        } else {
                            // 탈퇴 api 호출해서 db에서 삭제
                            print("탈퇴 완료")
                        }
                        
                    } label: {
                        Text("회원 탈퇴")
                    }
                }
            }
        }
        .navigationTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}


