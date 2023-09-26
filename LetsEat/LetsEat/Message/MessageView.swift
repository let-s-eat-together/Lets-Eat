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
    
    var body: some View {
        List {
            ForEach(dataManager.getMessageDummyData(), id: \.self) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text("콕 찔러보기")
                            .font(.system(.caption))
                        
                        Text("\(item.senderName)님이 회원님을 콕 찔렀습니다!")
                    }
                    
                    Spacer()
                    
                    VStack {
                        Text("~m ago")
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
