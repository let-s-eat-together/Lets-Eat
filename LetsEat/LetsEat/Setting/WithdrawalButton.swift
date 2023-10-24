//
//  WithdrawalButton.swift
//  LetsEat

import SwiftUI
import Alamofire

struct WithdrawalButton: View {
    @State var userManager = UserManager.shared
    @Binding var hasDelete: Bool
    
    var body: some View {
        Button {
            hasDelete.toggle()
        } label: {
            Text("탈퇴하기")
        }
        .alert(isPresented: $hasDelete) {
            Alert(title: Text("회원 탈퇴"),
                  message: Text("탈퇴 하시겠습니까?"),
                  primaryButton: Alert.Button.default(Text("네")) {
                deleteAccount()
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
    
    func deleteAccount() {
        let url = "http://34.22.94.135:8080/deleteUser"
        
        let params: Parameters = ["user_id": userManager.userInfo.id]
        
        let accessToken = userManager.userInfo.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
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
