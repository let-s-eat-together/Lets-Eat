//
//  PlanListView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

extension Date {
    func calcDate(from endDate: Date) -> Int {
        let Comp = Calendar.current.dateComponents([.day], from: Date(), to: endDate)
        guard let d = Comp.day else { return 0 }
        return d
    }    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "YY년 MM월 dd일"
        return formatter
    }
}

struct PlanListView: View {
    //    @State private var showMakePlanView: Bool = false
    //    @State private var isSting: Bool = false
    @State var dataManager = DataManager.shared
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                floatingButton()
                    .padding()
                    .zIndex(1)
                List {
                    ForEach(dataManager.getPlanDummyData(), id: \.self) { data in
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
    //
    //    private func makeTxt(_ day: Int) -> String {
    //        if day < 0 {
    //            return "약속일이 \(-day)일 지났습니다.."
    //        } else {
    //            return "약속까지 \(day)일 남았습니다.."
    //        }
    //    }
    //
    //    @ViewBuilder
    //    private func planItem(_ data: Plan) -> some View {
    //        HStack {
    //            Image("discord")
    //                .resizable()
    //                .scaledToFit()
    //                .frame(height: 40)
    //            Spacer()
    //            VStack(alignment: .leading) {
    //                Text(data.name)
    //                    .font(.title)
    //                let day = Date().calcDate(from: data.endDate)
    //                let txt = makeTxt(day)
    //                Text(txt)
    //                    .font(.caption)
    //                    .foregroundColor(.secondary)
    //            }
    //            Spacer()
    //            stingButton(planData: data)
    //                .buttonStyle(.plain)
    //        }
    //        .padding()
    //        .background(Rectangle().fill(Color("Item Color")))
    //        .cornerRadius(15)
    //        .shadow(color: .gray, radius: 3, x: 2, y: 2)
    //    }
    //
    //    @ViewBuilder
    //    private func floatingButton() -> some View {
    //        Button {
    //            showMakePlanView.toggle()
    //        } label: {
    //            Image(systemName: "plus.circle.fill")
    //                .resizable()
    //                .scaledToFit()
    //                .frame(width: 50)
    //                .foregroundColor(.primary)
    //                .fullScreenCover(isPresented: $showMakePlanView) {
    //                    MakePlanView()
    //                }
    //        }
    //    }
    
    //    @ViewBuilder
    //    private func stingButton(_ data: Plan) -> some View {
    //        Button {
    //            isSting.toggle()
    //        } label: {
    //            Image(systemName: "hand.point.left.fill")
    //                .foregroundColor(.primary)
    //
    //        }
    //        .alert(isPresented: $isSting) { // 마지막 이름 나오는 버그 고치기
    //            Alert(title: Text("콕 찌르기"),
    //                  message: Text("\(data.name)님을 콕 찌르시겠습니까?"),
    //                  primaryButton: Alert.Button.default(Text("네")) {
    //                      sendMessage(to: data.name)
    //                  },
    //                  secondaryButton: Alert.Button.destructive(Text("아니요")))
    //        }
    //    }
    //
    //    private func sendMessage(to who: String) { // 실패시 에러처리
    //        print("send to \(who) 콕!")
    //    }
}

struct planItem: View {
    var planData : Plan
    
    var body: some View {
        HStack {
            Image("discord")
                .resizable()
                .scaledToFit()
                .frame(height: 40)
            Spacer()
            VStack(alignment: .leading) {
                Text(planData.name)
                    .font(.title)
                let day = Date().calcDate(from: planData.endDate)
                let txt = makeTxt(day)
                Text(txt)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            stingButton(planData: planData)
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

struct floatingButton: View {
    var body: some View {
        HStack {
            Spacer()
            
            NavigationLink {
                MakePlanView()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50)
                    .foregroundColor(.primary)
            }
        }
    }
}

struct stingButton: View {
    @State private var isSting: Bool = false
    var planData : Plan
    
    var body: some View {
        Button {
            isSting.toggle()
        } label: {
            Image(systemName: "hand.point.left.fill")
                .foregroundColor(.primary)
        }
        .alert(isPresented: $isSting) { // 마지막 이름 나오는 버그 고치기
            Alert(title: Text("콕 찌르기"),
                  message: Text("\(planData.name)님을 콕 찌르시겠습니까?"),
                  primaryButton: Alert.Button.default(Text("네")) {
                sendMessage(to: planData.name)
            },
                  secondaryButton: Alert.Button.destructive(Text("아니요")))
        }
    }
    
    func sendMessage(to who: String) { // 실패시 에러처리
        print("send to \(who) 콕!")
    }
}


struct PlanListView_Previews: PreviewProvider {
    static var previews: some View {
        PlanListView()
    }
}
