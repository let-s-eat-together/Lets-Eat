//
//  FloatingButton.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/25.
//

import SwiftUI

struct FloatingButton: View {
    var body: some View {
        HStack {
            Spacer()
            
            NavigationLink {
                SetPlanView()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(.primary)
            }
        }
    }
}
