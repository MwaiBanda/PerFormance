//
//  Login.swift
//  Sell X Out
//
//  Created by Mwai Banda on 12/31/20.
//

import SwiftUI

struct Login: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errormessage = ""
    @EnvironmentObject var session : Session

    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        
        SecureField("Password", text: $password)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .background(Color(.systemGray6))
        
        Button(action: {
            session.Login(email: email, password: password, handler: { (result, error) in
                if error != nil {
                    self.errormessage = error?.localizedDescription ?? ""
                    let haptic = UINotificationFeedbackGenerator()
                    haptic.notificationOccurred(.error)
                   
                } else {
                    let haptic = UINotificationFeedbackGenerator()
                    haptic.notificationOccurred(.success)
                    UserDefaults.standard.setValue(email, forKey: "Stored_Email")
                    UserDefaults.standard.setValue(password, forKey: "Stored_Passcode")
                    print(UserDefaults.standard.string(forKey: "Stored_Passcode") as Any)
                    
                    self.email = ""
                    self.password = ""
                }
            })
        }){
            Text("Login")
                .foregroundColor(.white)
                .frame(width: UIScreen.main.bounds.width - 30)
                .padding(.vertical, 12)

        }
        .background(Color(.black))
        .cornerRadius(10)
            Spacer()
        }
        .padding(.horizontal)
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
