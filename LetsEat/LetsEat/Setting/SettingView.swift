//
//  settingView.swift
//  LetsEat

import SwiftUI
import Alamofire

struct SettingView: View {
    @AppStorage("isDarkModeOn") private var isDarkModeOn = false
    
    
    @StateObject var userManager = UserManager.shared
    
    @State private var isAlarmOn: Bool = false
    @State private var isOut: Bool = false
    @State private var hasDelete: Bool = false
    @State var isChanged: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section {
                    HStack {
                        Image("profile")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.all, 15)
                            .clipShape(Circle())
                        Text(userManager.getName())
                            .font(.title2)
                    }
                }
                
                Section {
                    NavigationLink("프로필 수정") {
                        EditProfileView(isChanged: $isChanged)
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
                    //                    NavigationLink("이용약관") {
                    //                        Text("이용약관")
                    //                    }
                    NavigationLink("개인정보 처리 방침") {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 20) {
                                Text("개인정보 처리방침")
                                    .font(.title)
                                    .bold()
                                
                                Text("1. 수집하는 개인정보의 항목 및 수집방법")
                                    .font(.headline)
                                
                                Text("1.1 수집하는 개인정보 항목:")
                                Text("- 기기의 고유 ID")
                                
                                Text("1.2 수집방법:")
                                Text("- 회원가입 시 앱이 자동으로 기기의 고유 ID를 수집합니다.")
                                
                                Text("2. 개인정보 수집 및 이용목적")
                                    .font(.headline)
                                
                                Text("2.1 회원가입 및 관리")
                                Text("- 회원 가입 시 기기의 고유 ID를 식별자로 사용하여 회원을 관리합니다.")
                                
                                Text("2.2 서비스 제공")
                                Text("- 기기의 고유 ID를 활용하여 서비스를 제공하고 개선합니다.")
                                
                                Text("2.3 법령 및 약관 준수")
                                Text("- 관련 법령 및 약관을 준수하기 위해 기기의 고유 ID를 이용합니다.")
                                
                                Text("3. 개인정보의 보유 및 파기")
                                    .font(.headline)
                                Text("- 수집한 개인정보를 회원탈퇴 등 이용목적이 달성된 경우 지체 없이 파기합니다. 단, 관련 법령에 따라 일정 기간 동안 정보를 보관할 수 있습니다.")
                                
                                Text("4. 개인정보의 제3자 제공")
                                    .font(.headline)
                                Text("- 기기의 고유 ID를 제3자에게 제공하지 않습니다.")
                                
                                Text("5. 개인정보의 열람, 수정 및 삭제")
                                    .font(.headline)
                                Text("- 이용자는 언제든지 자신의 개인정보를 열람, 수정 또는 삭제할 수 있습니다.")
                                
                                Text("6. 개인정보의 안전성 확보 조치")
                                    .font(.headline)
                                
                                Text("6.1 접근 제한")
                                Text("- 개인정보에 대한 접근은 필요한 최소한의 인원만이 가능하도록 제한됩니다.")
                                
                                Text("7. 개인정보 처리방침의 변경")
                                    .font(.headline)
                                Text("본 개인정보 처리방침은 법령, 정책 및 보안 기술의 변경에 따라 변경될 수 있습니다. 변경 사항이 있을 경우, 앱 내 공지사항을 통해 사전에 공지할 것입니다.")
                                
                            }
                        }
                        .padding()
                        .navigationBarTitle("개인정보 처리방침", displayMode: .inline)
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
        .alert(isPresented: $isChanged, content: {
            Alert(
                title: Text("프로필이 수정되었습니다!"),
                dismissButton: .default(Text("확인"))
            )
        })
        .navigationTitle("설정")
    }
}


struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}


