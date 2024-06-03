//
//  ContentView.swift
//  ShareLink
//
//  Created by Philippe MICHEL on 30/05/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var  image:Image?
    @State private var inputImage:UIImage?
    @State private var showLibrary:Bool = false
    @State private var showView:Bool = false
    @State private var shareText:String = ""
    var body: some View {

        TabView {
            // partager un lien
            VStack {
                Text("Partager un lien ")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.red)
                    .padding()
                
                ShareLink(item: URL(string: "https://www.titastus.com")!) {
                    Label("titastus.com", systemImage: "square.and.arrow.up.fill")
                }
            }
            .tabItem {
                Image(systemName: "link")
                Text("Lien")
            }
            // partager du texte
            VStack {
                    Text("Partager du texte")
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .foregroundStyle(.red)
                        
                    TextField("Taper votre texte", text: $shareText)
                    .padding()
                    .textFieldStyle(.roundedBorder)
                    if !shareText.isEmpty {
                        ShareLink(item: shareText) {
                            Label("Partager", systemImage: "square.and.arrow.up.fill")
                        }
                }
            }
            .tabItem {
                Image(systemName: "textformat.abc")
                Text("Texte")
            }
            // partager une image
            VStack {
                Text("Partager une photo")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .foregroundStyle(.red)
                image?
                    .resizable()
                    .cornerRadius(10)
                    .background(.red)
                    .frame(width: 250, height: 250)
                    .background(.red)
                    .cornerRadius(5)
                if !(image == nil) {
                    ShareLink(item: image!, preview: SharePreview("Image", image: image!)) {
                        Label("Partager", systemImage: "square.and.arrow.up.fill")
                    }
                }
                
                Button("Librairie Photo") {
                    self.showLibrary.toggle()
                }
                .buttonStyle(PlainButtonStyle())
                .frame(height: 50)
                .foregroundColor(.white)
                .padding(.horizontal)
                .background(.blue)
                .cornerRadius(10)
                .padding()
                .sheet(isPresented: $showLibrary) {
                    PhotoPicker(image: $inputImage)
                }
                .onChange(of:inputImage) {loadImage()}
            }
            .tabItem {
                Image(systemName: "photo")
                Text("Photo")
            }
            
            
        }
        .onAppear {
            
        }
    }
    //Chargement Image
    func loadImage() {
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
}

#Preview {
    ContentView()
}
