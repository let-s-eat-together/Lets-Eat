//
//  GenerateNicknameView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/11.
//

import SwiftUI
import Alamofire

struct GenerateNicknameView: View {
    @State private var input: String = ""
    @State private var isOK: Bool = false
    @State private var showAlert = false
    @State var userId: Int = -1
    private let deviceId = ContentView().deviceId
    var nicknameGenerated: () -> Void
    let regex = "^[^\\s]+$"
    
    var body: some View {
        NavigationStack {
            ZStack {
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
                        signUp(deviceId, nickname)
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
        let url = "http://34.22.94.135:8080/sign-up"
        let params: Parameters = ["username":nickname,"device_id":deviceId]
        
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
//        .responseData { response in
//            switch response.result {
//                case .success:
//                    print("성공")
//                case .failure:
//                    print(response.error.debugDescription)
//                }
//        }
        .responseDecodable(of: Signup.self, decoder: decoder) { response in
            userId = response.value?.userId ?? -2
            if userId == -2 {
                print("signup: data error")
            } else { // signup success
                print(userId)
            }
        }
    }
}

struct Signup: Decodable {
    let userId: Int
}

struct GenerateNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateNicknameView(nicknameGenerated: {})
    }
}
