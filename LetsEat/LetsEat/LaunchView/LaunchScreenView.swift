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
            Image("bab")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
        }
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
