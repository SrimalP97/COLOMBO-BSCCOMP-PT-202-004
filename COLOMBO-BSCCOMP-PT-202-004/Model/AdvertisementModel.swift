//
//  AdvertisementModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI

struct AdvertisementModel{
    var price: Double
    var category: String
    var landSize: Double
    var district: String
    var townVillage: String

}

struct PickerAdvertisements{
    var selected : [UIImage]
    var show : Bool
}

struct SingleImage{
    var images : Data
    var imagePicker : Bool
}

struct PostAds: Identifiable{
    var id = UUID().uuidString
    var price: Double
    var landORhouse: String
    var landSize: Double
    var district: String
    var townVillage: String
    var dateCreated : Date
    var imagesArray : [String]
    var province: String
    var deedImage : String
    var geo_location: String
    
    
}
