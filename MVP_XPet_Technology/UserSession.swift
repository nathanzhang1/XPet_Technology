//
//  UserSession.swift
//  MVP_XPet_Technology
//
//  Created by Nathan Zhang on 16/4/25.
//

import Foundation

class UserSession: ObservableObject {
    @Published var name: String = ""
    @Published var petName: String = ""
    @Published var isLoggedIn: Bool = false

    func login(with response: LoginResponse) {
        name = response.name
        petName = response.petName
        isLoggedIn = true
    }
}

