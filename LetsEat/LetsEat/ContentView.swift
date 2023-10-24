//
//  ContentView.swift
//  LetsEat

import SwiftUI
import Alamofire

struct ContentView: View {
    @ObservedObject var appState = AppState()
    
    @State private var isLoading: Bool = true
    @State private var isLoginSuccess: Bool = false
    
    @State var userManager = UserManager.shared
    @State var planManager = PlanManager.shared
    @State var messageManager = MessageManager.shared
    
    // test account
    // let deviceId = "device_id1"
    
    var body: some View {
        ZStack {
            VStack {
                PlanListView()
                    .id(appState.rootViewId)
                    .environmentObject(appState)
            }
            .zIndex(0)
            if isLoading {
                LaunchScreenView()
                    .transition(.opacity)
                    .zIndex(1)
            } else if !isLoginSuccess {
                SignUpView() {
                    isLoginSuccess = true
                }
                .zIndex(1)
            }
        }
        .onAppear {
            let deviceId = KeychainManager().getDeviceID()
            login(deviceId) { uid, name, tk in
                if uid == -1 {
                    print("sign up 진행")
                } else if uid == -2 {
                    print("login: data error")
                } else { // login success
                    print("token \(tk)")
                    print("userId \(uid)")
                    userManager.setInfo(id: uid, username: name, token: tk)
                    planManager.fetchPlans()
                    messageManager.fetchMessages()
                    isLoginSuccess = true
                }
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                withAnimation {
                    isLoading.toggle()
                }
            })
        }
    }
    
    func login(_ deviceId: String, completion: @escaping (Int, String, String)->Void) {
        //디바이스 아이디로 로그인 요청
        //있으면 유저 아이디 받아옴 -> 로그인 성공
        //없으면 -1을 받음 -> 로그인 실패, 닉네임 생성(signUp)
        let url = "http://34.22.94.135:8080/login"
        
        let params: Parameters = ["device_id": deviceId]
        
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
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case .success:
                print("로그인 성공")
            case .failure:
                print(response.error.debugDescription)
            }
        }
        .responseDecodable(of: Login.self, decoder: decoder) { response in
            let userId = response.value?.userId ?? -2
            let token = response.value?.token ?? "fail"
            let nickname = response.value?.name ?? "default"
            completion(userId, nickname, token)
        }
    }
    
    func loginProcess(userId uid: Int, token tk: String, username name: String) -> Void {
        if uid == -1 {
            print("sign up 진행")
        } else if uid == -2 {
            print("login: data error")
        } else { // login success
            print("token \(tk)")
            print("userId \(uid)")
            userManager.setInfo(id: uid, username: name, token: tk)
            planManager.fetchPlans()
            messageManager.fetchMessages()
            isLoginSuccess = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
