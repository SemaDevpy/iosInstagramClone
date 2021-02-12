//
//  DatabaseManager.swift
//  cloneInstagram
//
//  Created by Syimyk on 2/1/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import FirebaseDatabase




public class DataBasemanager{
    static let shared = DataBasemanager()

    
    
    
    
    private let database = Database.database().reference()
    
    /// Check if username and email is available
    public func canCreateNewUser(with email : String, username : String, completion: (Bool) -> Void){
        completion(true)
    }
    
    ///Inserts new user to realtime database
    public func insertNewUser(with email : String, username : String,completion : @escaping (Bool) -> Void ){
        database.child(email.safeDatabaseKey()).setValue(["username" : username]) { error, _ in
            if error == nil{
                completion(true)
                return
            }else{
                completion(false)
            }
        }
    }
    
    

    
}
