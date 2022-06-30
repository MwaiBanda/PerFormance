//
//  Session.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/23/21.
//

import Foundation
import FirebaseAuth
import Combine

class Session: ObservableObject {
    var didChange = PassthroughSubject<Session, Never>()
    var handle: AuthStateDidChangeListenerHandle?
    @Published var currentUser: User? {
        didSet {
            self.didChange.send(self)
        }
    }
    
    init() {
        listen()
    }
    
    
    func save<T: Encodable>(_ items: [T], key: String) {
        StoreUserDefaults.shared.saveCollection(items, key: key)
    }
    
    func load<T: Codable>(key: String) -> [T] {
        return StoreUserDefaults.shared.loadCollection(key: key)
    }
    
    func listen(){
        handle = Auth.auth().addStateDidChangeListener({ [weak self] (auth, user) in
            if let user = user {
                self?.currentUser = User(email: user.email)
            } else {
                self?.currentUser = nil
            }
        })
    }
    
    func SignUp(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
    func Login(email: String, password: String, handler: @escaping AuthDataResultCallback){
        Auth.auth().signIn(withEmail: email, password: password, completion: handler)
    }
    
    func LogOut(){
        self.currentUser = nil
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing Out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    deinit {
        unbind()
    }
}

extension Session {
    struct User {
        private(set) var userID: String
        private(set) var email: String?
        
        init(email: String?) {
            self.userID = Auth.auth().currentUser?.uid ?? ""
            self.email = email
            
        }
        
        var givenName: String { UserDefaults.standard.string(forKey: "storedFirstname") ?? "User" }
        var familyName: String { UserDefaults.standard.string(forKey: "storedSurname") ??
            String(UUID().uuidString.prefix(4))
        }
        var fullname: String { givenName + " " + familyName }
        var phoneNumber: String { UserDefaults.standard.string(forKey: "storedPhone") ?? "" }
    }
}
