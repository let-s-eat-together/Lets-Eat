//
//  LaunchScreenView.swift
//  LetsEat
//
//  Created by CNU on 2023/08/31.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color(.orange)
                .edgesIgnoringSafeArea(.all)
            VStack {
                Image("bab")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                HStack {
                    Text("유저 정보를 확인 중입니다..")
                        .foregroundColor(.gray)
                    ProgressView()
                }
            }
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
