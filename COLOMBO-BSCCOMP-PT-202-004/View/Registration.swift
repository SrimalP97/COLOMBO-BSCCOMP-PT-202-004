//
//  Registration.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI


struct Registration: View {
    @StateObject var advertisementVM = AdvertisementViewModel()
    @State var images : Data = Data()
    @State var imagePicker = false
    
    var body: some View {
        ZStack{
            VStack(spacing: 35){
                HStack{
                    Text("Create a Profile for You")
                        .font(.title)
                        .foregroundColor(.white)
                        .fontWeight(.bold)
                    Spacer(minLength: 0)
                }
                .padding(.top, 25)
                HStack(spacing: 25){
                    Button {
                        self.imagePicker.toggle()
                    } label: {
                        ZStack{
                            if self.images.count == 0{
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.blue)
                                Image(systemName: "plus")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.white)
                            }else{
                                Image(uiImage: UIImage(data: self.images)!)
                                    .resizable()
                                    .renderingMode(.original)
                                    .aspectRatio(contentMode: .fill)
                                    .frame(height: 100)
                                    .cornerRadius(10)
                                    .onAppear {
                                        advertisementVM.checkImage(image: UIImage(data: self.images)!)
                                    }
                            }
                        }
                        .frame(height: 100)
                    }

                }

                Spacer()
            }
        }
        .padding()
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .sheet(isPresented: self.$imagePicker){
            ImagePicker(showPicker: self.$imagePicker, imageData: self.$images)
        }
    }
}


