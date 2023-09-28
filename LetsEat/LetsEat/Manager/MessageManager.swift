//
//  MessageManager.swift
//  LetsEat
//
//

import Foundation

class MessageManager: ObservableObject {
    static let MSG_DATA_KEY = "MSG_DATA_KEY"
    static let shared = MessageManager()
    
    @Published var messageList: [Message] = []
    
    func getMessageDummyData() -> [Message] {
        return [Message(date: Date().addingTimeInterval(-3600), senderName: "이호수", receiverName: "조단현"),
                Message(date: Date().addingTimeInterval(-7210), senderName: "이현재", receiverName: "이호수"),
                Message(date: Date().addingTimeInterval(-10800), senderName: "김성민", receiverName: "이현재"),
                Message(date: Date().addingTimeInterval(-180), senderName: "송정현", receiverName: "김성민"),
                Message(date: Date(), senderName: "이현민", receiverName: "송정현"),
                Message(date: Date().addingTimeInterval(-300), senderName: "서은서", receiverName: "이현민"),
                Message(date: Date().addingTimeInterval(-1000), senderName: "조단현", receiverName: "서은서")]
    }
    
    
    init() {
        if let data = UserDefaults.standard.value(forKey: MessageManager.MSG_DATA_KEY) as? Data {
            let Item = try? PropertyListDecoder().decode([Message].self, from: data)
            if let list = Item {
                messageList = list
            }
        }
    }
    
    private func save() {
        if let encoded = try? JSONEncoder().encode(messageList) {
            UserDefaults.standard.set(encoded, forKey: MessageManager.MSG_DATA_KEY)
        }
    }
    
    func add(_ plan: Message) {
        messageList.append(plan)
        save()
    }
}
