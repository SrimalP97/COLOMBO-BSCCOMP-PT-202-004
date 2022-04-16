//
//  FirebaseHelper.swift
//  COLOMBO-BSCCOMP-PT-202-004
//
//  Created by Prabuddha Amunugama on 2022-04-15.
//

import SwiftUI
import Firebase
import FirebaseStorage

let storage = Storage.storage().reference()
let metadata = StorageMetadata()

let ref = Firestore.firestore()



func fetchUser(completion: @escaping (UserModel) -> ()){
    let uid = Auth.auth().currentUser!.uid
    ref.collection("Users").document(uid).getDocument{ (doc, err) in
        guard let user = doc else { return }
        
        let dob = user.data()?["dob"] as! String
        let email = user.data()?["email"] as! String
        let gender = user.data()?["gender"] as! String
        let mobile = user.data()?["mobile"] as! String
        let name = user.data()?["name"] as! String
        let nic = user.data()?["nic"] as! String
         
        DispatchQueue.main.async {
            completion(UserModel(dob: dob, email: email, gender: gender, mobile: mobile, name: name, nic: nic))
        }
    }
}

func UploadImage(imageData: [UIImage], path: String,completion: @escaping ([String]) -> ()){
    let uid = Auth.auth().currentUser!.uid
    var imagesArray:[String] = []
    
    let group = DispatchGroup()
        for img in 0..<(imageData.count) {

            group.enter()
            guard let data = imageData[img].jpegData(compressionQuality: 0.9) else {
                return
            }
            let ID = Date.now.ISO8601Format()
            metadata.contentType = "image/png"
            
            storage.child(path).child("\(uid)").child("\(img)_\(ID)").putData(data, metadata: metadata){ (_,err) in
                    if err != nil {
                        print(err?.localizedDescription as Any)
                        return
                    }

                // Downloading URL and Sending Back..
                storage.child(path).child("\(uid)").child("\(img)_\(ID)").downloadURL { (url, err) in
                    defer { group.leave() }
                        if err != nil {
                            print(err?.localizedDescription as Any)
                            return
                        }
                    imagesArray.append("\(url!)")
                    }
                }
        }
        group.notify(queue: .main) {
            completion(imagesArray)
    }
   
}

func UploadSingleImage(imageData: Data, path: String,completion: @escaping (String) -> ()){
    let uid = Auth.auth().currentUser!.uid
    guard let singleImage = UIImage(data: imageData), let image = singleImage.jpegData(compressionQuality: 0.9) else{
        return
    }
    let ID = Date.now.ISO8601Format()
    metadata.contentType = "image/png"
    
    storage.child(path).child(uid).child("deedImage_\(ID)").putData(image, metadata: metadata){ (_,err) in
        if err != nil {
            completion("")
            return
        }
        
        // Downloading URL and Sending Back..
        storage.child(path).child(uid).child("deedImage_\(ID)").downloadURL { (url, err) in
            if err != nil {
                completion("")
                return
            }
            completion("\(url!)")
        }
    }
}
