//
//  ContentView.swift
//  HelloWorld
//
//  Created by Ricky Hu on 2022/5/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            // Health Sharing
            VStack {
                LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .leading, endPoint: .trailing)
                    .frame(width: 96, height: 64, alignment: .center)
                    .mask(
                        Image(systemName: "person.2.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 96.0)
                    ).padding()
                
                Text("Health Sharing")
                    .font(.system(size: 40))
                    .bold()
                    .fontWeight(.heavy)
                
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "checklist")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32)
                            .foregroundColor(.blue)
                            .padding()
                        VStack(alignment: .leading) {
                            Text("You're in Control")
                                .bold()
                                .font(.system(size: 20))
                                .padding([.bottom], 2)
                            Text("Keep friends and family up to date on how you're doing by securely sharing your Health data.")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }.padding([.horizontal], 0)
                    }
                    
                    HStack {
                        Image(systemName: "bell.badge.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32.0)
                            .foregroundColor(.blue)
                            .padding()
                        VStack(alignment: .leading) {
                            Text("Dashboard and Notifications")
                                .bold()
                                .font(.system(size: 20))
                                .padding([.bottom], 2)
                            Text("Data you share will appear in their Health app. They can also get notifications if there's an update.")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }.padding([.horizontal], 0)
                    }
                    
                    HStack {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 32.0)
                            .foregroundColor(.blue)
                            .padding()
                        VStack(alignment: .leading) {
                            Text("Private and Secure")
                                .bold()
                                .font(.system(size: 20))
                                .padding([.bottom], 2)
                            Text("Only a summary of each topic is shared, not the details. The information is encrypted and you can stop sharing at any time. Share with someone")
                                .foregroundColor(.gray)
                                .font(.system(size: 16))
                        }.padding([.horizontal], 0)
                    }
                }
                .padding([.horizontal], 0)
                .padding([.vertical], 16)
                
                Button("Share with Someone") {}
                    .padding([.horizontal], 20)
                    .padding([.vertical], 8)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(25)
                
            }
            .padding(32)
            
            // News
            VStack {
                Image("news-image")
                    .resizable()
                    .scaledToFit()
                Text("News+")
                    .bold()
                    .font(.system(size: 32))
                    .fontWeight(.black)
                    .padding([.vertical], 2)
                Text("Great news!")
                    .font(.system(size: 28))
                    .fontWeight(.heavy)
                Text("Audio stories are here.")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.pink)
                Text("Listen only in Apple News+")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                Button("Get Started") {}
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding([.vertical], 12)
                    .foregroundColor(.white)
                    .background(.pink)
                    .cornerRadius(16)
                Text("Plan auto-renews for $9.99/month until canceled")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .padding()
            }.padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
