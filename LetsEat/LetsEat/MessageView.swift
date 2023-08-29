//
//  MessageView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct MessageView: View {
    @State private var messageList: [Message] = [Message(tag: .sting, name: "조단현"),
                                  Message(tag: .extend, name: "이호수"),
                                  Message(tag: .sting, name: "이현재"),
                                  Message(tag: .request, name: "김성민"),
                                  Message(tag: .sting, name: "송정현"),
                                  Message(tag: .accept, name: "이현민"),
                                  Message(tag: .sting, name: "서은서")]
    
    var body: some View {
        List {
            ForEach(messageList, id: \.self) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.tag.rawValue)
                            .font(.system(.caption))
                        switch item.tag {
                        case .sting:
                            Text("\(item.name)님이 찔렀습니다.")
                        case .extend:
                            Text("\(item.name)님과의 약속 기간이\n연장되었습니다.")
                        case .request:
                            Text("\(item.name)님이 친구 요청을\n보냈습니다.")
                        case .accept:
                            Text("\(item.name)님이 친구 요청을\n수락했습니다.")
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
//                        Text("\(item.date)~m ago")
                        Text("~m ago")
                        HStack {
                            collectButton()
                            
                            rejectButton()
                        }
                    }
                    .padding()
                }
                .navigationTitle("알림")
            }
            .onDelete(perform: removeList)
        }
        .toolbar {
            EditButton()
        }

    }
    
    func removeList(at offsets: IndexSet) {
        messageList.remove(atOffsets: offsets)
    }
}

struct collectButton: View {
    var body: some View {
        Button {
            sendCorrect()
        } label: {
            Image(systemName: "checkmark.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 25, height: 25)
                .foregroundColor(.green)
        }
    }
    
    func sendCorrect() {
        
    }
}

struct rejectButton: View {
    var body: some View {
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
    
    func sendReject() {
        
    }
    
}
struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
