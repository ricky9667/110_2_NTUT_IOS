//
//  ContentView.swift
//  imageClassification
//
//  Created by mac mini on 2022/6/15.
//

import SwiftUI

struct ContentView: View {
    let model = MobileNetV2()
    let photos = ["bird", "cat", "dog", "monkey", "pangolin"]
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @State private var currentIndex: Int = 0
    @State private var classificationLabel: String = "Click Classify"
    @State private var results: [String] = []
    
    private func performImageClassification() {
        let currentImage = photos[currentIndex]
        
        let img = UIImage(named: currentImage)
        let resizedImage = img?.resizeTo(size: CGSize(width: 224, height: 224))
        let buffer = resizedImage?.toBuffer()
        
        let output = try? model.prediction(image: buffer!)
        
        if let output = output {
            let data = output.classLabelProbs.sorted { $0.1 > $1.1 }
            
            results = data.map { (key, value) in
                return "\(key) = \(value * 100)%"
            }
            print(results)
//            classificationLabel = result
        }
    }
    
    var body: some View {
        VStack {
            Image(photos[currentIndex])
                .resizable()
                .frame(width: 200, height: 200)
            HStack {
                Button("Previous") {
                    if self.currentIndex > 0 {
                        self.currentIndex = self.currentIndex - 1
                    } else {
                        self.currentIndex = self.photos.count - 1
                    }
                    
                }.padding()
                    .background(Color(red: 0.7098039215686275, green: 0.8705882352941177, blue: 1.0))
                    .cornerRadius(10)
                    .frame(width: 100)
                
                Button("Next") {
                    if self.currentIndex < self.photos.count - 1 {
                        self.currentIndex = self.currentIndex + 1
                    } else {
                        self.currentIndex = 0
                    }
                    self.classificationLabel = "Click Classify"
                }
                .padding()
                .frame(width: 100)
                .background(Color(red: 0.7098039215686275, green: 0.8705882352941177, blue: 1.0))
                .cornerRadius(10)
            
            }.padding()
            
            Button("Classify") {
                self.performImageClassification()
            }.padding()
                .background(Color(red: 0.7568627450980392, green: 1.0, blue: 0.8431372549019608))
                .cornerRadius(8)
            
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(0 ..< results.count, id: \.self) { index in
                        Text("\(results[index])")
                    }
                }
            }
            
            Text(classificationLabel)
                .font(.largeTitle)
                .padding()
            Divider()
            Spacer()
        }
        .background(Color(#colorLiteral(red: 0.988235294, green: 1, blue: 0.650980392, alpha: 1)))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
