//
//  FirebaseHelper.swift
//  CustomChat
//
//  Created by Asad Butt on 02/11/2021.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol FirebaseHelperProtocol {
    func FetchMessageFromFirebase(messgae:MessageModel)
}

class FirebaseHelper{
    
    var firebaseHelperProtocol: FirebaseHelperProtocol!
    
    func fetchMessages(orderNumber:String){
        
        Firestore.firestore().collection("orders").document(orderNumber).collection("messages").addSnapshotListener { [self] querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        let timestamp = diff.document.data()["timestamp"] as! Int
                        let text = diff.document.data()["text"] as! String
                        let user = diff.document.data()["user"] as! String
                        let type = diff.document.data()["type"] as! String
                        let userMessage = MessageModel.init(text: text, timestamp: timestamp, user: user, type: type)
                        print("userMessage \(userMessage)")
                        firebaseHelperProtocol.FetchMessageFromFirebase(messgae: userMessage)
                    }
                    if (diff.type == .modified) {
                        print("Modified city: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        print("Removed city: \(diff.document.data())")
                    }
                }
            }
    
    }
    func sendMessage(user:String,text:String,type:String , timestamp:Int , productId:String){
        Firestore.firestore().collection("orders").document(productId).collection("messages").addDocument(data: [
            "text": text,
            "timestamp": timestamp,
            "type":type,
            "user":user,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("document added")
            }
        }
        
    }
    
}


