//
//  HomeViewModel.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//


import SwiftUI
import Firebase

class HomeViewModel: ObservableObject {
    @Published var filteredAdvertisement: [PostAds] = []
    @Published var advertisementPost: [PostAds] = []
    @Published var search = ""
    @Published var message = ErrorMessageModel(alert: false, error: "", topic: "Error", isLoading: false, guestUser: false)
    @Published var filterArray = ["Price Low to High", "Price High to Low"]
    @Published var filteredData = "Price"
    @Published var showDetails = false
    @Published var selecetdADS : PostAds!
    let province = UserDefaults.standard.string(forKey: "province")
    
    init(){
        getAllPosts()
        print(advertisementPost)
    }
    
    func getAllPosts(){
        
        ref.collection("Advertisement").addSnapshotListener { (snap , err) in
            guard let docs = snap else {
                return
            }
            
            if docs.documentChanges.isEmpty{
                return
            }
            
            docs.documentChanges.forEach { (doc) in
                // Checking If docs Added
                if doc.type == .added{
                    // retreiving and appending ...
                    let geo_location = doc.document.data()["geo_location"] as! String
                    let townVillage = doc.document.data()["townVillage"] as! String
                    let district = doc.document.data()["district"] as! String
                    let landSize = doc.document.data()["landSize"] as! Double
                    let landORhouse = doc.document.data()["landORhouse"] as! String
                    let price = doc.document.data()["price"] as! Double
                    let province = doc.document.data()["province"] as! String
                    let deedImage = doc.document.data()["deedImage"] as! String
                    let imagesArray = doc.document.data()["imagesArray"] as! [String]
                    let dateCreated = doc.document.data()["dateCreated"] as! Timestamp
    
                    self.advertisementPost.append(PostAds(price: price, landORhouse: landORhouse, landSize: landSize, district: district, townVillage: townVillage, dateCreated: dateCreated.dateValue(), imagesArray: imagesArray, province: province, deedImage: deedImage, geo_location: geo_location))
                    
                    self.advertisementPost.sort { (p1,p2) -> Bool in
                        return p1.dateCreated > p2.dateCreated
                    }
                    self.filteredAdvertisement = self.advertisementPost.filter{
                        return $0.province.lowercased().contains(self.province?.lowercased() ?? "Western Province ")
                    }
                }
            }
        }
    }
    
    func searchData(){
        withAnimation(.linear){
            self.filteredAdvertisement = self.advertisementPost.filter{
                return $0.landORhouse.lowercased().contains(self.search.lowercased())
            }

        }
    }
    
    func highToLow(){
        withAnimation(.linear){
            self.filteredAdvertisement.sort { (p1,p2) -> Bool in
                return p1.price > p2.price
            }

        }
    }
    
    func lowToHigh(){
        withAnimation(.linear){
            self.filteredAdvertisement.sort { (p1,p2) -> Bool in
                return p1.price < p2.price
            }

        }
    }

}





