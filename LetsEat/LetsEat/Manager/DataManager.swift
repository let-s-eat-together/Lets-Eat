//
//  DataManager.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import Foundation

class DataManager: ObservableObject {
    static let DATA_LIST_KEY = "DATA_LIST_KEY"
    static let shared = DataManager()
    
    @Published var dataList: [Message] = []
    
    func getPlanDummyData() -> [Plan] {
        return [
            Plan(
                expiredDate: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 1)) ?? Date.now, otherUserId: "조단현"),
            Plan(
            
                 expiredDate: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 1)) ?? Date.now, otherUserId: "이현재"),
            Plan(
            
                 expiredDate: Calendar.current.date(from: DateComponents(year: 2023, month: 10, day: 30)) ?? Date.now, otherUserId: "이호수"),
            Plan(
            
                 expiredDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 1)) ?? Date.now, otherUserId: "이현민"),
            Plan(
            
                 expiredDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 10)) ?? Date.now, otherUserId: "김성민"),
            Plan(
            
                 expiredDate: Calendar.current.date(from: DateComponents(year: 2023, month: 11, day: 30)) ?? Date.now, otherUserId: "서은서"),
            Plan(
            
                 expiredDate: Calendar.current.date(from: DateComponents(year: 2023, month: 12, day: 25)) ?? Date.now, otherUserId: "송정현")]
    }
    
    func getMessageDummyData() -> [Message] {
        return [Message(senderName: "이호수", receiverName: "조단현"),
                Message(senderName: "이현재", receiverName: "이호수"),
                Message(senderName: "김성민", receiverName: "이현재"),
                Message(senderName: "송정현", receiverName: "김성민"),
                Message(senderName: "이현민", receiverName: "송정현"),
                Message(senderName: "서은서", receiverName: "이현민"),
                Message(senderName: "조단현", receiverName: "서은서")]
    }
    
    init() {
        if let data = UserDefaults.standard.value(forKey: DataManager.DATA_LIST_KEY) as? Data {
            let dataListItem = try? PropertyListDecoder().decode([Message].self, from: data)
            if let list = dataListItem {
                dataList = list
            }
        }
    }
    
    func getList() -> [Message] {
        let returnList: [Message] = dataList
        return returnList
    }
    
    func dataSync() -> Bool {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(dataList), forKey: DataManager.DATA_LIST_KEY)
        return UserDefaults.standard.synchronize()
    }
    
    func add(MemoItem item: Message?) -> Bool {
        if let data = item {
            dataList.append(data)
            return dataSync()
        }
        return false
    }
    
    func save(MemoItem aItem: Message?) -> Bool {
        if let data = aItem {
            for (idx, item) in dataList.enumerated() {
                if item.id.hashValue == data.id.hashValue {
                    dataList.remove(at: idx)
                    dataList.append(item)
                }
            }
        }
        return false
    }
    
    func updateList() {
        let list = dataList
        dataList = list
    }
    
    func remove(_ indexSet: IndexSet) -> Bool {
        dataList.remove(atOffsets: indexSet)
        return dataSync()
    }
    
    func move(frome source: IndexSet, to destination: Int) -> Bool {
        dataList.move(fromOffsets: source, toOffset: destination)
        return dataSync()
    }
}
