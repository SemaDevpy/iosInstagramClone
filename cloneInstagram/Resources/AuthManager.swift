//
//  AuthManager.swift
//  cloneInstagram
//
//  Created by Syimyk on 2/1/21.
//  Copyright © 2021 Syimyk. All rights reserved.
//

import FirebaseAuth

public class AuthManager{
    static let shared = AuthManager()
    
    //MARK: - Public functions everyone in app can use.
    public func registerNewUser(username : String, email : String, password : String, completion : @escaping (Bool) -> Void){
        //Check if username is available
        //Check if email is available
        
    
        DataBasemanager.shared.canCreateNewUser(with: email, username: username){canCreate in
            if canCreate{
                //Create account
                //Insert account to database
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil, result != nil else{
                        completion(false)
                        return
                    }
                    DataBasemanager.shared.insertNewUser(with: email, username: username){ inserted in
                        if inserted{
                            completion(true)
                            return
                        }else{
                            completion(false)
                        }
                    }
                }
            }
            else{
                completion(false)
            }
        }
    }
    
    
    
    public func loginUser(username : String?, email : String?, password : String, completion : @escaping  (Bool) -> Void ){
        if let email = email{
            Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                guard authResult != nil, error == nil else{
                    completion(false)
                    return
                }
                completion(true)
                
            }
        }else if let username = username{
            print(username)
        }
        
        
    }
    
}
