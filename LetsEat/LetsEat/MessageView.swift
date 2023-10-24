//
//  MessageView.swift
//  LetsEat

import SwiftUI

struct MessageView: View {
    @State var messageManager = MessageManager.shared
    
    var body: some View {
        @State var messageList = messageManager.messageList
        List {
            ForEach(messageList, id: \.id) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text("콕 찔러보기")
                            .font(.system(.caption))
                        
                        Text("\(item.otherUserName)님이 \(item.countSting)번 콕 찔렀습니다!")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text(timeElapsedString(for: item.creationDate.toDateTime() ?? Date.now))
                            .font(.system(.caption))
                            .foregroundColor(.gray)
                    }
                    .padding()
                }
            }
            //            .onDelete(perform: removeList)
        }
        .navigationTitle("알림")
        
        .refreshable {
            messageManager.fetchMessages()
        }
//        .toolbar {
//            EditButton()
//        }
        
    }
    
    //    func removeList(at offsets: IndexSet) {
    //        messageManager.messageList.remove(atOffsets: offsets)
    //    }
    
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
