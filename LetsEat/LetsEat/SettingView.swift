//
//  SettingView.swift
//  LetsEat
//
//  Created by 이현재 on 2023/08/28.
//

import SwiftUI

struct SettingView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
            Spacer()
            
            //                Text("Settings")
            //                    .padding()
            //                    .font(.largeTitle)
            //                    .bold()
            //                    .multilineTextAlignment(.leading)
            
            HStack {
                Image("discord")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .padding()
                
                
                //                Spacer()
                
                VStack(alignment: .leading) {
                    Text("Hyunjae Lee")
                        .bold()
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
                        Text("Personal Information")
                        
                    }
                    NavigationLink {
                        Text("Change Password detail")
                    } label: {
                        Image(systemName: "lock")
                        Text("Change Password")
                    }
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
                    NavigationLink {
                        Text("Logout View")
                    } label: {
                        Label("Logout", systemImage: "door.left.hand.open")
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
