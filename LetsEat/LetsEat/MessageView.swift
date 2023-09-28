//
//  MessageView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct MessageView: View {
//    @State var dataManager = DataManager.shared
    @State var messageManager = MessageManager.shared
    
    @State private var messageList: [Message] = []
    
    var body: some View {
        List {
            ForEach(messageManager.getMessageDummyData(), id: \.self) { item in
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
                        Button("같이 찌르기") {
                            
                        }
                        .font(.system(.caption))
                        .cornerRadius(8)
                        .padding(.top, 1)
                        
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
