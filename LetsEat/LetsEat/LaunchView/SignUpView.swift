//
//  SignUpView.swift
//  LetsEat

import SwiftUI
import Alamofire


struct SignUp: Decodable {
    let userId: Int
}

struct SignUpView: View {
    @State var username: String = ""
    @State var userManager = UserManager.shared
    @State var planManager = PlanManager.shared
    @State var messageManager = MessageManager.shared
    
    @State private var isOK: Bool = false
    @State private var showAlert = false
    
    @State var userId: Int = -1
    var nicknameGenerated: () -> Void
    let regex = "^[^\\s]+$"
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer()
                
                Text("회원가입")
                    .font(.system(.title))
                    .bold()
                    .padding()
                
                HStack {
                    TextField("이름을 입력해주세요...", text: $username)
                        .onChange(of: username) { newValue in
                            isOK = newValue.range(of: regex, options: .regularExpression) != nil
                        }
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            username = ""
                        }
                }
                .padding()
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .strokeBorder()
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
                .font(.system(.subheadline))
                .padding()
                
                Spacer()
            }
            .frame(width: 300)
            .padding()
            
            Button {
                if isOK {
                    let nickname = username
                    let deviceId = KeychainManager().getDeviceID()
                    signUp(deviceId, nickname)
                    nicknameGenerated()
                } else {
                    showAlert = true
                }
            } label: {
                Text("완료")
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("닉네임이 올바르지 않습니다!"),
                    dismissButton: .default(Text("확인")))
            }
            .padding()
            
            Spacer()
        }
    }
    
    private func signUp(_ deviceId: String, _ username: String) {
        let url = "http://34.22.94.135:8080/sign-up"
        
        let params: Parameters = [
            "username": username,
            "device_id": deviceId
        ]
        
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        let decoder : JSONDecoder = {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SignUp.self, decoder: decoder) { response in
            userId = response.value?.userId ?? -2
            if userId == -2 {
                print("signup: data error")
            } else { // signup success
                print("회원가입 성공")
                print("userId \(userId)")
                ContentView().login(deviceId) { uid, name, tk in
                    print("token \(tk)")
                    print("userId \(uid)")
                    userManager.setInfo(id: uid, username: name, token: tk)
                    planManager.fetchPlans()
                    messageManager.fetchMessages()
                }
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(nicknameGenerated: {})
    }
}
