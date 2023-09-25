//
//  PlanListView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct PlanListView: View {
    @State var dataManager = DataManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                FloatingButton()
                    .padding()
                    .zIndex(1)
                List {
                    ForEach(dataManager.getPlanDummyData()) { data in
                        planItem(planData: data)
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
                Text(planData.otherUserId)
                    .font(.title)
                let day = Date().calcDate(from: planData.expiredDate)
                let txt = makeTxt(day)
                Text(txt)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            StingButton(otherUserId: planData.otherUserId)
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
