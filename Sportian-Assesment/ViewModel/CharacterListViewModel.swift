//
//  CharacterListViewModel.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import Foundation

class CharacterListViewModel: ObservableObject {
    @Published var characters = [Character]()
    @Published var searchText = ""

    // Loading state
    @Published var isLoading = true

    private let repository: CharacterRepositoryProtocol
    private var currentPage = 1
    private var isFetching = false
    private var hasMoreCharacters = true // Track if more pages are available

    init(repository: CharacterRepositoryProtocol = CharacterRepository()) {
        self.repository = repository
        fetchCharacters()
    }

    func fetchCharacters() {
        guard !isFetching && hasMoreCharacters else { return }
        isFetching = true
        isLoading = true

        Task {
            do {
                try await Task.sleep(for: .seconds(3)) // 2 seconds delay

                let newCharacters = try await repository.fetchCharacters(page: currentPage)

                DispatchQueue.main.async {
                    self.characters += newCharacters
                    self.currentPage += 1
                    self.isFetching = false
                    self.isLoading = false
                    self.hasMoreCharacters = !newCharacters.isEmpty
                }
            } catch let error as CharacterError {
                print("Error fetching characters: \(error.localizedDescription)")
                self.isFetching = false
                self.isLoading = false
            } catch {
                print("Unexpected error: \(error.localizedDescription)")
                self.isFetching = false
                self.isLoading = false
            }
        }
    }

    var filteredCharacters: [Character] {
        return searchText.isEmpty ? characters : characters.filter {
            $0.name.lowercased().contains(searchText.lowercased())
        }
    }
}
