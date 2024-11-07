//
//  AppCoordinator.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var selectedCharacterID: Int?

    func selectCharacter(_ characterID: Int) {
        selectedCharacterID = characterID
    }

    func clearSelection() {
        selectedCharacterID = nil
    }
}
