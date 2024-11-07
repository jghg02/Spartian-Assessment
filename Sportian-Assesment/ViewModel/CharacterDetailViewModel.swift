//
//  CharacterDetailViewModel.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var character: Character?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let repository: CharacterRepositoryProtocol
    private var characterID: Int

    init(repository: CharacterRepositoryProtocol, characterID: Int) {
        self.repository = repository
        self.characterID = characterID
        fetchCharacterDetails()
    }

    func fetchCharacterDetails() {
        isLoading = true
        Task { @MainActor in
            do {
                let character = try await repository.fetchCharacter(by: characterID)
                self.character = character
                self.isLoading = false
            } catch {
                self.errorMessage = "Failed to load character details"
                self.isLoading = false
            }
        }
    }
}
