//
//  QRCodeImageView.swift
//  LetsEat

import SwiftUI
import CoreImage.CIFilterBuiltins


struct QRCodeImage {
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    func generateQRCode(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct QRCodeImageView: View {
    @EnvironmentObject var appState: AppState
    @State var userManager = UserManager.shared
    
    @Binding var expirationDate: Date
    
    var body: some View {
        VStack {
            let expirationDate = self.expirationDate.ymdFormat()
            let userId = userManager.userInfo.id
            Image(uiImage: QRCodeImage().generateQRCode(from: "\(expirationDate)\n\(userId)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            
            Button {
                appState.rootViewId = UUID()
            } label: {
                Text("완료")
                    .font(.system(size: 20))
            }
            .buttonStyle(.bordered)
            .buttonBorderShape(.roundedRectangle(radius: 10))
            .padding()
        }
    }
}


struct QRCodeImageView_Previews: PreviewProvider {
    static var previews: some View {
        QRCodeImageView(expirationDate: .constant(Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 1)) ?? Date.now))
    }
}
