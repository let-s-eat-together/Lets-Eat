//
//  ContentView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    topView()
                    
                    PlanListView()
                        .scrollContentBackground(.hidden)
                }
                VStack {
                    Spacer()
                    floatingButton(planDate: Date())
                }
                .padding()
            }
        }
    }
}

struct topView: View {
    var body: some View {
        // top
        HStack {
            Text("약속 리스트")
                .font(.system(.largeTitle))
                .bold()
            
            Spacer()
            HStack {
                NavigationLink {
                    MessageView()
                } label: {
                    Image(systemName: "bell.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.primary)
                }
                
                NavigationLink {
                    SettingView()
                        
                } label: {
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 35, height: 35)
                        .foregroundColor(.primary)
                }



            }
        }
        .padding(.horizontal, 20)
    }
}

struct floatingButton: View {
    @State private var isMake: Bool = false
    @State var planDate: Date
    
    var dateFormatter: DateFormatter {
         let formatter = DateFormatter()
        formatter.dateStyle = .medium
         return formatter
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            Button {
                isMake.toggle()
            } label: {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .foregroundColor(.primary)
            }
            .sheet(isPresented: $isMake) {
                VStack(alignment: .center) {
                    
                    DatePicker(selection: $planDate, in: Date()..., displayedComponents: .date) {
                        Text("날짜를 선택해주세요")
                    }
                    .padding()
                    
                    
                    Text("시작 : \(Date(), formatter: dateFormatter)")
                        .padding()
                    
                    Text("종료 : \(planDate, formatter: dateFormatter)")
                        .padding()
                    Button {
                        isMake.toggle()
                        makePlan()
                    } label: {
                        Text("약속 만들기")
                    }
                    .padding()
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))

                    
                }
            }
        }
    }
    
    func makePlan() {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
