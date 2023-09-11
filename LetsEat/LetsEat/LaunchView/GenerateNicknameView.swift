//
//  GenerateNicknameView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/11.
//

import SwiftUI

struct GenerateNicknameView: View {
    @State private var input: String = ""
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {
                Spacer()
                Text("닉네임")
                    .font(.callout)
                    .bold()
                ZStack(alignment: .trailing) {
                    TextField("닉네임을 입력해주세요...", text: $input)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .onTapGesture {
                            input = ""
                        }
                }
                VStack(alignment: .trailing) {
                    Text("사용가능한 닉네임입니다.")
                        .foregroundColor(.green)
                    Text("사용불가한 닉네임입니다.")
                        .foregroundColor(.red)
                }
                Spacer()
                Spacer()
            }
            .frame(width: 300)
            .padding()
        }
    }
}

struct GenerateNicknameView_Previews: PreviewProvider {
    static var previews: some View {
        GenerateNicknameView()
    }
}
