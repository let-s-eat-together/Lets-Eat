//
//  settingView.swift
//  LetsEat

import SwiftUI
import Alamofire

struct SettingView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    @State var userManager = UserManager.shared
  
    @State private var isAlarmOn: Bool = false
    @State private var isOut: Bool = false
    @State private var hasDelete: Bool = false
    
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
                        Text(userManager.userInfo.username)
                            .font(.title2)
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
                        VStack {
                            Image("bab")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                            Text("현재 버전 1.0.0")
                            
                            Text("최선 버전 입니다.")
                                .font(.caption)
                        }
                    }
                }
                
                Section {
                    LogOutButton(isOut: $isOut)
                    
                    WithdrawalButton(hasDelete: $hasDelete)
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


