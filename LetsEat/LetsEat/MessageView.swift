//
//  MessageView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct MessageView: View {
//    @State var dataMan2ager = DataManager.shared
    @State var messageManager = MessageManager.share
    
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
            ForEach(messageManager.messageList, id: \.self) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text("콕 찔러보기")
                            .font(.system(.caption))
                        
                        Text("\(item.senderName)님이 콕 찔렀습니다!")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text(timeElapsedString(for: item.date))
                            .font(.system(.caption))
                            .foregroundColor(.gray)
                        
                        StingButton(otherUserId: item.senderName)
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
    
    func timeElapsedString(for date: Date) -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour, .minute],
                                                 from: date, to: Date())
        
        if let days = components.day, days > 0 {
            return "\(days)d ago"
        } else if let hours = components.hour, hours > 0 {
            return "\(hours)h ago"
        } else if let minutes = components.minute, minutes > 0 {
            return "\(minutes)m ago"
        } else {
            return "now"
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
    }
}
