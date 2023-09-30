//
//  MessageView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct MessageView: View {
    @State var dataManager = DataManager.shared
    
    @State private var messageList: [Message] = []
    
    func getMessageDummyData() -> [Message] {
        return [Message(senderName: "이호수", receiverName: "조단현"),
                Message(senderName: "이현재", receiverName: "이호수"),
                Message(senderName: "김성민", receiverName: "이현재"),
                Message(senderName: "송정현", receiverName: "김성민"),
                Message(senderName: "이현민", receiverName: "송정현"),
                Message(senderName: "서은서", receiverName: "이현민"),
                Message(senderName: "조단현", receiverName: "서은서")]
    }
    
    var body: some View {
        List {
            ForEach(getMessageDummyData(), id: \.self) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text("콕 찔러보기")
                            .font(.system(.caption))
                        
                        Text("\(item.senderName)님이 회원님을 콕 찔렀습니다!")
                    }
                    
                    Spacer()
                    
                    VStack {
//                        Text("\(item.date)~m ago")
                        Text("~m ago")
//                        stingButton(title: "나도 콕 찔러보기")
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

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
