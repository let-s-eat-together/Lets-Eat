//
//  QRCodeImageView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/31.
//

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
    @Environment(\.dismiss) private var dismiss
    
    var userId = UUID().uuidString
    @Binding var expirationDate: Date
    
    var body: some View {
        VStack {
            Image(uiImage: QRCodeImage().generateQRCode(from: "\(expirationDate)"))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
            
            Button {
                dismiss()
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
        QRCodeImageView( expirationDate: .constant(Date()))
    }
}
