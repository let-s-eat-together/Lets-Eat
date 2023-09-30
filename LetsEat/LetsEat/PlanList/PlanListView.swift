//
//  PlanListView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct PlanListView: View {
    @ObservedObject var planManager = PlanManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                FloatingButton()
                    .padding()
                    .zIndex(1)
                List {
                    if planManager.planList.isEmpty {
                        Text("약속이 없습니다")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundStyle(.secondary)
                    } else {
                        ForEach(planManager.planList, id: \.id) {data in
                            planItem(planData: data)
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                .navigationTitle("밥 함 묵자")
                .toolbar {
                    NavigationLink {
                        MessageView()
                    } label: {
                        Image(systemName: "bell.fill")
                            .foregroundColor(.primary)
                    }
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(.primary)
                    }
                }
                .zIndex(0)
            }
        }
    }
}

struct planItem: View {
    var planData: Plan
    
    var body: some View {
        HStack {
            Image("discord")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            
            Spacer()
            
            VStack(alignment: .leading) {
                Text(planData.otherUserName)
                    .font(.title)
                let day = Date().calcDate(from: planData.expirationDate.toDay() ?? Date.now)
                let txt = makeTxt(day)
                Text(txt)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            
            StingButton(otherUserId: planData.otherUserName)
                .buttonStyle(.plain)
        }
        .padding()
        .background(Rectangle().fill(Color("Item Color")))
        .cornerRadius(15)
        .shadow(color: .gray, radius: 3, x: 2, y: 2)
    }
    
    private func makeTxt(_ day: Int) -> String {
        if day < 0 {
            return "약속일이 \(-day)일 지났습니다.."
        } else {
            return "약속까지 \(day)일 남았습니다.."
        }
    }
}

struct PlanListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListView()
    }
}
