//
//  CameraView.swift
//  LetsEat

import SwiftUI
import CodeScanner
import Alamofire

struct CameraView: View {
    @EnvironmentObject var appState: AppState
    @State private var isShowingScanner = false
    @State private var isCreate = false
    @State var userManager = UserManager.shared
    
    var body: some View {
        Button {
            isShowingScanner = true
        } label: {
            Text("QR코드 스캔하기")
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson\n2023-11-30 12:00:00", completion: handleScan)
        }
        .alert("약속이 생성되었습니다", isPresented: $isCreate) {
            Button(role: .cancel) {
                appState.rootViewId = UUID()
                PlanManager().fetchPlans()
            } label: {
                Text("완료")
            }
        }
    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let data):
            let details = data.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let expirationDate = details[0]
            let senderId = details[1]
            sendPlanData(expirationDate, senderId)
            print("Found code: \(data)")
        case .failure(let error):
            print("Failed Scan QR Code because of \(error)")
        }
    }
    
    func sendPlanData(_ expirationDate: String, _ senderId: String) {
        let url = "http://34.22.94.135:8080/plan"
        
        let accessToken = userManager.userInfo.token
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        
        let params: Parameters = [
            "expired_date": expirationDate,
            "sender_id": Int(senderId) ?? 0,
            "receiver_id": 0
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseData { response in
            debugPrint(response)
            switch response.result {
            case .success(let data):
                print("Success: \(data)")
                isCreate = true
            case .failure(let error):
                print("Error: \(error)")
                debugPrint(response)
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
