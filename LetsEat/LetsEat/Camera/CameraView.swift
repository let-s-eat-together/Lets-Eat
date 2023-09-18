//
//  CameraView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/16.
//

import SwiftUI
import CodeScanner

struct CameraView: View {
//    enum FilterType {
//        case none, contacted, uncontacted
//    }
//    let filter: FilterType
    
    @State private var isShowingScanner = false
    
    
    var body: some View {
        Button {
            isShowingScanner = true
        } label: {
            Text("QR코드 스캔하기")
        }
        .sheet(isPresented: $isShowingScanner) {
            CodeScannerView(codeTypes: [.qr], simulatedData: "Paul Hudson.com\npaul@hackingwithswift.com", completion: handleScan)
        }
    }
    
//    var title: String {
//        switch filter {
//        case .none:
//            return "Everyone"
//        case .contacted:
//            return "Contacted"
//        case .uncontacted:
//            return "Uncontacted"
//        }
//    }
    
    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let data):
            let details = data.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            
            let plan = Plan()
            plan.creationDate = Date.now
            plan.otherUserName = details[0]
            plan.expirationDate = details[1].toDate() ?? Date.now
            print("Found code: \(data)")
        case .failure(let error):
            print("Failed Scan QR Code because of \(error)")
        }

    }
}

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        return dateFormatter.string(from: self)
    }
}

extension String {
    func toDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = .current
        if let date = dateFormatter.date(from: self) {
            return date
        } else {
            return nil
        }
    }
}
struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
