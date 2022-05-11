//
//  ContentView.swift
//  HelloWorld
//
//  Created by Ricky Hu on 2022/5/2.
//

import SwiftUI

struct Tab1View: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink {
                    ImageView(image: "cat1")
                } label: {
                    Text("Cat1")
                }
                NavigationLink {
                    ImageView(image: "cat2")
                } label: {
                    Text("Cat2")
                }
                NavigationLink {
                    ImageView(image: "cat3")
                } label: {
                    Text("Cat3")
                }
                NavigationLink {
                    ImageView(image: "cat4")
                } label: {
                    Text("Cat4")
                }
                NavigationLink {
                    ImageView(image: "cat5")
                } label: {
                    Text("Cat5")
                }
            }.navigationTitle("Pudding Cat")
        }.navigationViewStyle(.stack)
    }
}

struct Tab2View: View {
    var body: some View {
        VStack {
            Text("Images")
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    Image("cat1")
                        .resizable()
                        .scaledToFit()
                    Image("cat2")
                        .resizable()
                        .scaledToFit()
                    Image("cat3")
                        .resizable()
                        .scaledToFit()
                    Image("cat4")
                        .resizable()
                        .scaledToFit()
                    Image("cat5")
                        .resizable()
                        .scaledToFit()
                }
            }
        }
    }
}

struct ImageView: View {
    let image: String
    var body: some View {
        VStack {
            Text(image)
            Image(image)
                .resizable()
                .scaledToFit()
        }
    }
}

struct Tab3View: View {
    let data = [
        "Name: Pudding Cat",
        "Gender: Male",
        "Age: 9 years old"
    ]
    
    var body: some View {
        let columns = [GridItem()]
        VStack {
            LazyVGrid(columns: columns) {
                ForEach(data.indices, id: \.self) { item in
                    VStack {
                        Text(data[item])
                    }
                }
            }
            Link("Visit Pudding", destination: URL(string: "https://www.instagram.com/pudding_cat_123456/")!)
        }
    }
}

struct ContentView: View {
    var body: some View {
        TabView {
            Tab1View()
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("First")
                }
            Tab2View()
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Second")
                }
            Tab3View()
                .tabItem {
                    Image(systemName: "3.square.fill")
                    Text("Third")
                }
        }
        .font(.headline)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
