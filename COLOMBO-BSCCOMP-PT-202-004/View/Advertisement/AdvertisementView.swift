//
//  AdvertisementView.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI

struct AdvertisementView: View {
    @StateObject var advertisementVM = AdvertisementViewModel()
    @StateObject var locationManager = LocationManagerHelper()

    var body: some View {
        ZStack{
            GeometryReader{_ in
                ScrollView{
                    LazyVStack{
                        VStack(alignment: .leading){
                            Text("Geo Location")
                                .foregroundColor(.gray)
                                .font(.caption)
                            HStack(spacing: 15){
                                Image(systemName: "paperplane.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.white)
                                    .padding()
                                    .background(Color("Color"))
                                    .cornerRadius(6)
                                
                                Text(locationManager.userLati == "0" ? "Geo Location" : "\(locationManager.userLati) , \(locationManager.userLong)")
                                    .padding(.horizontal,10)
                                
                                Spacer()
                            
                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(Color("Color"), lineWidth: 2)
                                )
                        }
                        .padding(.top, 10)
                    
                        VStack(alignment: .leading){
                            Text("Select Deed Image")
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                            HStack(spacing: 15){
                                   Button {
                                       self.advertisementVM.singleImage.imagePicker.toggle()
                                   } label: {
                                       ZStack{
                                           if self.advertisementVM.singleImage.images.count == 0{
                                               RoundedRectangle(cornerRadius: 4)
                                                   .fill(Color.white)
                                               Image(systemName: "plus")
                                                   .font(.system(size: 24, weight: .bold))
                                                   .foregroundColor(Color("Color"))
                                           }else{
                                               Image(uiImage: UIImage(data: self.advertisementVM.singleImage.images)!)
                                                   .resizable()
                                                   .renderingMode(.original)
                                                   .aspectRatio(contentMode: .fill)
                                                   .frame(height: 100)
                                                   .cornerRadius(4)
                                                   .onChange(of: self.advertisementVM.singleImage.images) { newValue in
                                                       self.advertisementVM.singleImage.images = newValue
                                                       advertisementVM.checkImage(image: UIImage(data: self.advertisementVM.singleImage.images)!)
                                                   }
                                                   .onAppear{
                                                       advertisementVM.checkImage(image: UIImage(data: self.advertisementVM.singleImage.images)!)
                                                   }
                                           }
                                       }
                                       .frame(height: 100)
                                       .background(
                                           RoundedRectangle(cornerRadius: 4)
                                            .stroke(self.advertisementVM.singleImage.images.isEmpty ? Color.black.opacity(0.7) : Color("Color"), lineWidth: 2)
                                       )
                                   }

                              }
                        }
                        .padding(.top, 10)

                        VStack(alignment: .leading){
                            Text("Select Property Images")
                                .foregroundColor(.gray)
                                .font(.caption)
                            HStack(spacing: 15){
                                Text("\(self.advertisementVM.pickerAdvertisement.selected.count) Selected")
                                    .padding(.horizontal,10)
                                Spacer()

                                Button {
                                    self.advertisementVM.pickerAdvertisement.selected.removeAll()
                                    self.advertisementVM.pickerAdvertisement.show.toggle()
                                } label: {
                                    Image(systemName: "plus")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.white)
                                        .padding()
                                }
                                .background(Color("Color"))
                                .cornerRadius(6)

                                }
                                .background(
                                    RoundedRectangle(cornerRadius: 4)
                                        .stroke(self.advertisementVM.pickerAdvertisement.selected.isEmpty ? Color.black.opacity(0.7) : Color("Color"), lineWidth: 2)
                                )
                            
                                if !self.advertisementVM.pickerAdvertisement.selected.isEmpty{
                                    ScrollView(.horizontal, showsIndicators: false){
                                        LazyHStack(spacing: 20){
                                            ForEach(self.advertisementVM.pickerAdvertisement.selected, id: \.self){i in
                                                    Image(uiImage: i)
                                                        .resizable()
                                                        .frame(width: UIScreen.main.bounds.width / 4,height: 100)
                                                        .cornerRadius(20)
                                            }
                                        }
                                        .padding(.horizontal, 10)
                                    }
                                }
                        }
                        .padding(.top, 10)


                        TextField("Price", value: self.$advertisementVM.advertisement.price, formatter: advertisementVM.formatter)
                            .keyboardType(.decimalPad)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(self.advertisementVM.advertisement.price != 0.0 ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                            )
                            .padding(.top, 10)
                    
                    TextField("Land / House", text: self.$advertisementVM.advertisement.category)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(self.advertisementVM.advertisement.category != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                        )
                        .padding(.top, 10)
                    
                    TextField("Land Size", value: self.$advertisementVM.advertisement.landSize, formatter: advertisementVM.formatter)
                        .keyboardType(.decimalPad)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(self.advertisementVM.advertisement.landSize != 0.0 ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                        )
                        .padding(.top, 10)
                    
                    TextField("District", text: self.$advertisementVM.advertisement.district)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(self.advertisementVM.advertisement.district != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                        )
                        .padding(.top, 10)
                    
                    TextField("Town/Village", text: self.$advertisementVM.advertisement.townVillage)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(self.advertisementVM.advertisement.townVillage != "" ? Color("Color") : Color.black.opacity(0.7), lineWidth: 2)
                        )
                        .padding(.top, 10)
                        
                }
                .padding(.horizontal, 25)
             }
            }
            if self.advertisementVM.pickerAdvertisement.show{
                CustomPicker(selected: self.$advertisementVM.pickerAdvertisement.selected, show: self.$advertisementVM.pickerAdvertisement.show)
            }
            if self.advertisementVM.message.alert{
                GeometryReader{_ in
                    ErrorMessagesView(alert: self.$advertisementVM.message.alert,
                                      error: self.$advertisementVM.message.error,
                                      topic: self.$advertisementVM.message.topic,
                                      loading: self.$advertisementVM.message.isLoading, guestUser: $advertisementVM.message.guestUser)
                }
            }
        }
        .onAppear {
            locationManager.locationManager.delegate = locationManager
        }
        .sheet(isPresented: self.$advertisementVM.singleImage.imagePicker){
            ImagePicker(showPicker: self.$advertisementVM.singleImage.imagePicker, imageData: self.$advertisementVM.singleImage.images)
        }
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    self.advertisementVM.userLatitude = "\(locationManager.userLati)"
                    self.advertisementVM.userLongitude = "\(locationManager.userLong)"
                    self.advertisementVM.validation()
                } label: {
                    Text("Post Ads")
                }

            }
        }
        
    }
}

