//
//  AuthManager.swift
//  HabitTracker
//
//  Created by Purvesh Dodiya on 06/01/24.
//

import Foundation
import Firebase

class AuthManager: ObservableObject {
    
    @Published var isLoggedIn: Bool = false
   static var shared = AuthManager()
    
    func checkAuthenticationStatus() {
        Auth.auth().addStateDidChangeListener { _, user in
            self.isLoggedIn = user != nil
        }
    }


    func signout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
        isLoggedIn = false
    }
    
    func deleteAccount() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }

        try await user.delete()

        DispatchQueue.main.async {
            self.isLoggedIn = false
        }
    }
}
