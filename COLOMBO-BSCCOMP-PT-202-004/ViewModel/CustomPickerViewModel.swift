//
//  CustomPickerViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//

import SwiftUI
import Photos

class CustomPickerViewModel: ObservableObject {
    @Published var pickerModel = PickerImageModel(data: [], grid: [], disbaledPhotos: false)
    
    func getAllImages(){
        DispatchQueue.global(qos: .background).async {
            let req = PHAsset.fetchAssets(with: .image, options: .none)
            req.enumerateObjects { (assest, _, _) in
                let options = PHImageRequestOptions()
                options.isSynchronous = true
                
                PHCachingImageManager.default().requestImage(for: assest, targetSize: .init(), contentMode: .default, options: options) { (image, _) in
                    DispatchQueue.main.async {
                        let data1 = Images(image: image!, selected: false)
                        self.pickerModel.data.append(data1)
                    }
                }
            }
            
            if req.count == self.pickerModel.data.count{
                self.getGrid()
            }
        }
    }
    
    func getGrid(){
        for i in stride(from: 0, to: self.pickerModel.data.count, by: 3){
            self.pickerModel.grid.append(i)
        }
    }

}


