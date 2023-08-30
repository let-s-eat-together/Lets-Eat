//
//  SettingView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct SettingView: View {
    @State private var isAlarm: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            

            
            //                Text("Settings")
            //                    .padding()
            //                    .font(.largeTitle)
            //                    .bold()
            //                    .multilineTextAlignment(.leading)
            
            HStack {
                Image("discord")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .padding()
                
                
                //                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Hyunjae Lee")
                        .font(.title2)
//                        .bold()
//                        Text("Student")
//                            .font(.caption)
//                            .foregroundColor(.gray)
//                        Button {
//
//                        } label: {
//                            Text("Edit Profile")
//                                .font(.system(size: 13))
//                                .padding()
//                                .tint(.white)
//                                .frame(width: 100, height: 40)
//                                .background(.blue)
//                                .cornerRadius(25)
//                        }
                }
            }
            List {
                Section {
                    NavigationLink {
                        Text("Personal information detail")
                    } label: {
                        Image(systemName: "person")
                        Text("프로필 설정")
                    }
//                    NavigationLink {
//                        Text("Change Password detail")
//                    } label: {
//                        Image(systemName: "lock")
//                        Text("Change Password")
//                    }
                    NavigationLink {
                        Text("Personal information detail")
                    } label: {
                        HStack {
                            Image(systemName: "moon")
                            Text("Theme")
                            Spacer()
                            Text("Light")
                                .foregroundColor(.gray)
                                .font(.callout)
                        }
                    }
                }
                Section {
////                    NavigationLink {
////                        Text("Logout View")
////                    } label: {
////                        Label("Logout", systemImage: "door.left.hand.open")
//                    }
                }
                
                Section {
                    Toggle(isOn: $isAlarm) {
                        Text("푸시 알림")
                    }
                    Toggle(isOn: $isAlarm) {
                        Text("푸시 알림")
                    }
                
                }
            }
        }
        .navigationTitle("설정")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
