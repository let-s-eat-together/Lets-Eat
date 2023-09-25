//
//  CameraView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/16.
//

import SwiftUI
import CodeScanner
import Alamofire

struct CameraView: View {
    @State private var isShowingScanner = false
    @State private var isCreate = false
    
    @State var expiredDate: Date = Date()
    @State var otherUserId: String = ""
    
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
            expiredDate = details[0].toDate() ?? Date.now
            otherUserId = details[1]
            sendPlanData(expiredDate, otherUserId)
            print("Found code: \(data)")
        case .failure(let error):
            print("Failed Scan QR Code because of \(error)")
        }
    }
    
    func sendPlanData(_ expiredDate: Date, _ otherUserId: String) {
        let url = "http://34.22.94.135:8080/plan"
        let params: Parameters = ["expiredDate": expiredDate, "otherUserId": otherUserId]
        let header: HTTPHeaders = ["Content-Type": "application/json"]
        
        //        let decoder : JSONDecoder = {
        //            let decoder = JSONDecoder()
        //            decoder.keyDecodingStrategy = .convertFromSnakeCase
        //            return decoder
        //        }()
        
        AF.request(url,
                   method: .post,
                   parameters: params,
                   encoding: JSONEncoding.default,
                   headers: header)
        .validate(statusCode: 200..<300)
        .responseData { response in
            switch response.result {
            case .success:
                print("성공")
                isCreate = true
            case .failure:
                print(response.error.debugDescription)
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
