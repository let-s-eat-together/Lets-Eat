//
//  FloatingButton.swift
//  LetsEat

import SwiftUI

struct FloatingButton: View {
    var body: some View {
        VStack {
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

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton()
    }
}
