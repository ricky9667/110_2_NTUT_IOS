//
//  ContentView.swift
//  HelloWorld
//
//  Created by Ricky Hu on 2022/5/2.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var isLoginSuccess: Bool = false
    @State private var showLoginAlert: Bool = false
    @State private var showLogoutAlert: Bool = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isGuest: Bool = Auth.auth().currentUser == nil
    @State var isActive: Bool = false
    
    
    func getUserInfo() -> String {
        let user = Auth.auth().currentUser
        var data = ""
        if user != nil {
            if let displayName = user?.displayName {
                data += displayName
            } else {
                data += "Anonymous"
            }
            data += "\n"
            if let email = user?.email {
                data += email
            } else {
                data += "No email"
            }
        } else {
            data = "Guest"
        }
        return data
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(getUserInfo())
                    .padding()
                
                Button("Logout") {
                    if Auth.auth().currentUser != nil {
                        do {
                            try Auth.auth().signOut()
                            isGuest = true
                        } catch {
                            print(error)
                        }
                    }
                    showLogoutAlert = true
                }
                    .disabled(isGuest)
                    .alert("Logged out", isPresented: $showLogoutAlert) {}
            }
                
            
            TextField("username", text: $username)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding()
            
            SecureField("password", text: $password)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding()
            
            Button("Login") {
                let email = "\(username)@example.com"
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                    showLoginAlert = true
                    isLoginSuccess = (error == nil)
                    
                    if !isLoginSuccess {
                        return
                    }
                    
                    if let user = Auth.auth().currentUser {
                        print("user \(user.uid)")
                        isGuest = false
                    } else {
                        print("guest")
                    }
                    
                    username = ""
                    password = ""
                }
            }
                .alert(isLoginSuccess ? "Login success" : "Login failed", isPresented: $showLoginAlert) {}
                .padding([.horizontal], 20)
                .padding([.vertical], 8)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(25)
            
            HStack {
                Text("Not registered?")
                NavigationLink(
                    destination: RegisterView(rootIsActive: self.$isActive),
                    isActive: self.$isActive
                ) {
                    Text("Create an account")
                }
                    .navigationTitle("Login")
            }.padding()
        }
    }
}

struct RegisterView: View {
    @Binding var rootIsActive: Bool
    @State private var isRegisterSuccess: Bool = false
    @State private var showRegisterAlert: Bool = false
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            TextField("name", text: $name)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding()
            
            TextField("username", text: $username)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding()
            
            SecureField("password", text: $password)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
                .border(.secondary)
                .padding()
            
            Button("Register") {
                let email = "\(username)@example.com"
                Auth.auth().createUser(withEmail: email, password: password) { result, error in
                    showRegisterAlert = true
                    isRegisterSuccess = (error == nil)
                    
                    if !isRegisterSuccess {
                        return
                    }
                    
                    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                    changeRequest?.displayName = name
                    changeRequest?.commitChanges(completion: { error in
                       guard error == nil else {
                           return
                       }
                    })
                    
                    name = ""
                    username = ""
                    password = ""
                }
            }
                .alert(isRegisterSuccess ? "Register success" : "Register failed", isPresented: $showRegisterAlert) {}
                .padding([.horizontal], 20)
                .padding([.vertical], 8)
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(25)
            
            HStack {
                Text("Already registered?")
                Button(action: { self.rootIsActive = false}) {
                    Text("Login here")
                }
            }.padding()
        }
    }
}

struct ContentView: View {
    var body: some View {
        LoginView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
