//
//  ImageCardView.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI

struct ImageCardView : View {
    @State var data: Images
    @Binding var selected : [UIImage]
    var body: some View{
        ZStack{
            Image(uiImage: self.data.image)
                .resizable()
                
            if self.data.selected{
                ZStack{
                    Color.black.opacity(0.5)
                    Image(systemName: "checkmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                }
            }
        }
        
        
        .frame(width: (UIScreen.main.bounds.width - 80) / 3, height: 90)
        .onTapGesture {
            if(self.selected.count < 9){
                if !self.data.selected{
                    self.data.selected = true
                    self.selected.append(self.data.image)
                }else{
                    for i in 0..<self.selected.count{
                        if self.selected[i] == self.data.image{
                            self.selected.remove(at: i)
                            self.data.selected = false
                            return
                        }
                    }
                }
            }else{
                self.data.selected = false
            }
        }

    }
}
