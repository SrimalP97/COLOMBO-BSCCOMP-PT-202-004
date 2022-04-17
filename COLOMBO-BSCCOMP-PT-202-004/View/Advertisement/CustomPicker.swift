//
//  CustomPicker.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//

import SwiftUI
import Photos


struct CustomPicker: View {
    @StateObject var customPickerVM = CustomPickerViewModel()
    @Binding var selected : [UIImage]
    @Binding var show: Bool
    
    var body: some View {
        VStack{
            VStack {
                
                if !self.customPickerVM.pickerModel.grid.isEmpty{
                    HStack{
                        Text("Select (\(self.selected.count)/9) Photos")
                            .fontWeight(.bold)
                        Spacer()
                    }
                    .padding(.leading)
                    .padding(.top)

                    ScrollView(.vertical, showsIndicators: true){
                        VStack(alignment: .leading, spacing: 20){
                            ForEach(self.customPickerVM.pickerModel.grid, id: \.self){i in
                                HStack(spacing: 8){
                                    ForEach(i..<i+3, id: \.self){j in
                                        HStack{
                                            if j < self.customPickerVM.pickerModel.data.count{
                                                ImageCardView(data: self.customPickerVM.pickerModel.data[j], selected: self.$selected)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    
                    Button {
                        self.show.toggle()
                    } label: {
                        Text("Select")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.vertical)
                            .frame(width: UIScreen.main.bounds.width - 50)
                    }
                    .background(Color.green.opacity((self.selected.count != 0) ? 1 : 0.5))
                    .cornerRadius(10)
                    .padding(.horizontal,20)
                    .padding(.bottom, 25)
                    .disabled((self.selected.count != 0) ? false : true)
                }
                else{
                    if self.customPickerVM.pickerModel.disbaledPhotos{
                        Text("Goto Settings and Enable Storage Access In Photos")
                    }else{
                        ProgressView("Please wait...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .black))
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width - 40 , height: UIScreen.main.bounds.height / 1.5 )
            .background(Color.white)
            .cornerRadius(12)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(
            Color.black.opacity(0.35).edgesIgnoringSafeArea(.all)
            .onTapGesture {
                self.show.toggle()
        })

        
        .onAppear{
            PHPhotoLibrary.requestAuthorization({ (status) in
                switch(status){
                    case .authorized :
                        self.customPickerVM.getAllImages()
                        self.customPickerVM.pickerModel.disbaledPhotos = false
                    case .denied :
                        self.customPickerVM.pickerModel.disbaledPhotos = true
                    case .notDetermined :
                        self.customPickerVM.pickerModel.disbaledPhotos = true
                    default :
                        self.customPickerVM.pickerModel.disbaledPhotos = true
                        break
                }
            })

        }
    }
        
}
