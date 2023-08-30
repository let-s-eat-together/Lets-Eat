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
                        Text(item.tag.rawValue)
                            .font(.system(.caption))
                        switch item.tag {
                        case .sting:
                            Text("\(item.name)님이 콕 찔렀습니다.")
//                        case .extend:
//                            Text("\(item.name)님과의 약속 기간이\n연장되었습니다.")
//                        case .request:
//                            Text("\(item.name)님이 친구 요청을\n보냈습니다.")
                        case .accept:
                            Text("\(item.name)님이 수락했습니다.")
                        default:
                            Text("default")
                        }
                    }
                    
                    Spacer()
                    
                    VStack {
//                        Text("\(item.date)~m ago")
                        Text("~m ago")
                        HStack {
                            if item.tag == .sting {
                                collectButton()
                                
                                rejectButton()
                            }
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
