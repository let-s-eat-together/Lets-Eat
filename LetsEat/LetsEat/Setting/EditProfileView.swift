//
//  EditProfileView.swift
//  LetsEat

import SwiftUI
import Alamofire

struct EditProfileView: View {
    @State private var isOK: Bool = false
    @State private var showAlert = false
    @State var userManager = UserManager.shared
    @State var username: String = ""
    
    let regex = "^[^\\s]+$"

    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Spacer()
                
                Text("프로필 수정")
                    .font(.system(.title))
                    .bold()
                    .padding()
                
                HStack {
                    TextField("이름을 수정해주세요...", text: $username)
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
                    updateNickname(nickname)
                    presentationMode.wrappedValue.dismiss()
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
    
    private func updateNickname(_ username: String) {
        let url = "http://34.22.94.135:8080/rename"
        
        let accessToken = userManager.userInfo.token
        
        let headers : HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "user_name": username
        ]
        
        AF.request(url,
                   method: .put,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseData { response in
            debugPrint(response)
            switch response.result {
                case .success:
                    print("이름이 변경되었습니다.")
                    userManager.setName(name: username)
                case .failure:
                    print(response.error.debugDescription)
            }
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
