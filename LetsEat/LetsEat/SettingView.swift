import SwiftUI

struct SettingView: View {
    @AppStorage("appTheme") var appTheme: String = "light" // 테마 지정
    
    @State private var isAlarmOn: Bool = false
    @State private var isDarkOn: Bool = false
    @State private var nickname: String = "eunseo"
    @State private var editedNickname: String = ""
    @State private var isEditingNickname: Bool = false
    
    var isNicknameValid: Bool {
        return editedNickname.count >= 1
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                Section {
                    HStack {
                        Image("discord")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40, height: 40)
                            .padding(.all, 15)
                            .foregroundColor(.white)
                            .clipShape(Circle())
                        VStack(alignment: .leading) {
                            if isEditingNickname {
                                TextField("변경할 이름", text: $editedNickname)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .frame(width: 160)
                                    .onAppear {
                                        editedNickname = nickname
                                    }
                            } else {
                                Text(nickname)
                                    .font(.headline)
                            }
                        }
                        Spacer()
                        Button(action: {
                            isEditingNickname.toggle()
                            if !isEditingNickname {
                                if isNicknameValid {
                                    nickname = editedNickname
                                }
                            }
                        }) {
                            Text(isEditingNickname ? "완료" : "프로필 수정")
                                .foregroundColor(.blue)
                        }
                    }
                }
                
                Section {
                    Toggle(isOn: $isAlarmOn) {
                        Text("푸시 알림")
                    }
                    Toggle(isOn: $isDarkOn) {
                        Text("다크 모드")
                    }
                    .onChange(of: isDarkOn) { newValue in
                        appTheme = newValue ? "dark" : "light"
                    }
                }
            }
        }
        .preferredColorScheme(appTheme == "dark" ? .dark : .light)
    }
    
    struct SettingView_Previews: PreviewProvider {
        static var previews: some View {
            SettingView()
        }
    }
}
