//
//  AdvertisementViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//






import UIKit
import Vision
import SwiftUI
import Firebase


class AdvertisementViewModel: ObservableObject {
    let NIC = UserDefaults.standard.string(forKey: "userNIC") ?? ""
    let ref = Firestore.firestore()
    var locationManager = LocationManagerHelper()
    @Published var userLatitude: String = "0"
    @Published var userLongitude: String = "0"
    @Published var advertisement = AdvertisementModel(price: 0.0 , category: "", landSize: 0.0, district: "", townVillage: "")
    @Published var pickerAdvertisement = PickerAdvertisements(selected: [], show: false)
    @Published var singleImage = SingleImage(images: Data(), imagePicker: false)
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false, guestUser: false)
    var imageFlag = false
    
    
    @Published var formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    //OCR Checking Word and match to Given NIC
    func checkImage(image: UIImage){
        if let cgImage = image.cgImage {
          let requestHandler = VNImageRequestHandler(cgImage: cgImage)

          let recognizeTextRequest = VNRecognizeTextRequest { (request, error) in
            guard let observations = request.results as? [VNRecognizedTextObservation] else {
              return
            }
            
            let recognizedStrings = observations.compactMap { observation in
              observation.topCandidates(1).first?.string
            }
            
            DispatchQueue.main.async {
//                print(recognizedStrings)
                if recognizedStrings.contains(where: {$0 == "NIC . \(self.NIC)V" }){
                    print("Yes Contain Words")
                    self.imageFlag = true
                }else{
                    print("No Not Contain Words")
                    self.imageFlag = false
                    self.message.alert.toggle()
                    self.message.error = "This is not a original deed image. Please Attach Original Deed image"
                }
                
            }
          }
          
          recognizeTextRequest.recognitionLevel = .fast
          
          DispatchQueue.global(qos: .userInitiated).async {
            do {
              try requestHandler.perform([recognizeTextRequest])
            } catch {
              print(error)
            }
          }
        }
    }
    
    
    func validation(){
        if self.advertisement.price == 0.0{
            self.message.alert.toggle()
            self.message.error = "Price Cannot be empty!"
        }else if self.advertisement.category == ""{
            self.message.alert.toggle()
            self.message.error = "Land/House Cannot be empty!"
        }else if self.advertisement.landSize == 0.0 {
            self.message.alert.toggle()
            self.message.error = "Land size Cannot be empty!"
        }else if self.advertisement.district == ""{
            self.message.alert.toggle()
            self.message.error = "District Cannot be empty!"
        }else if self.advertisement.townVillage == ""{
            self.message.alert.toggle()
            self.message.error = "Town/Viilage Cannot be empty!"
        }else if !self.imageFlag || self.singleImage.images.isEmpty {
            self.message.alert.toggle()
            self.message.error = "This is not valid Image or Image Cannot be empty"
        }else{
            Upload()
        }
    }
    

    func Upload(){
        self.message.isLoading = true
        self.message.alert.toggle()
            UploadSingleImage(imageData: singleImage.images, path: "Advertisement") { url in
               
                UploadImage(imageData: self.pickerAdvertisement.selected, path: "Advertisement") { imageArray in
                    
                    let province = UserDefaults.standard.string(forKey: "province")!
                    self.ref.collection("Advertisement").document("\(Date.now.ISO8601Format())").setData([
                        "geo_location" : "\(self.userLatitude), \(self.userLongitude)",
                        "townVillage" :self.advertisement.townVillage,
                        "district" : self.advertisement.district,
                        "landSize" : self.advertisement.landSize,
                        "landORhouse" : self.advertisement.category,
                        "price" : self.advertisement.price,
                        "province" : province,
                        "deedImage" : url,
                        "imagesArray" : imageArray.map{ $0 },
                        "dateCreated" : Date()

                    ]) { (err) in
                        if err != nil {
                            self.message.isLoading = false
                            self.message.error = err!.localizedDescription
                        }else{
                            self.message.isLoading = false
                            self.message.topic = "Success"
                            self.message.error = "Advertisement Uploaded Successfully"
                            self.advertisement = AdvertisementModel(price: 0.0 , category: "", landSize: 0.0, district: "", townVillage: "")
                            self.pickerAdvertisement = PickerAdvertisements(selected: [], show: false)
                            self.singleImage = SingleImage(images: Data(), imagePicker: false)
                        }
                    }
                }
            }

    }
}









