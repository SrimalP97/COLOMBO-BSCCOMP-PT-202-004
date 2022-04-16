//
//  PickerImageModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//

import SwiftUI

struct PickerImageModel{
    var data : [Images]
    var grid : [Int]
    var disbaledPhotos : Bool
}

struct Images{
    var image : UIImage
    var selected : Bool
}

