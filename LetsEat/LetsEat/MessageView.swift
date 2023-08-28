//
//  MessageView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct MessageView: View {
    var body: some View {
        Form {
            ForEach(0..<9) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text("Tag")
                        Text("@@@님이 찔렀습니다.")
                        Text("caption")
                    }
                    
                    Spacer()
                    VStack {
                        Text("~m ago")
                        HStack {
                            Button {
                                sendCorrect()
                            } label: {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.green)
                            }
                            
                            Button {
                                sendReject()
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 25, height: 25)
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .padding()
                //                                .background(.ultraThinMaterial)
            }
            .onDelete(perform: removeItem)
            .navigationTitle("알림")
        }
        .toolbar {
            EditButton()
        }
    }
    
    func sendCorrect() {
        
    }
    
    func sendReject() {
        
    }
    func removeItem(at indexSet: IndexSet) {
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
