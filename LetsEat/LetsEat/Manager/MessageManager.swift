//
//  MessageManager.swift
//  LetsEat
//
//  Created by 이현재 on 2023/09/19.
//

import Foundation

class MessageManager: ObservableObject {
    static let MSG_DATA_KEY = "MSG_DATA_KEY"
    static let share = MessageManager()
    
    @Published var messageList: [Message] = []
    
    
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
