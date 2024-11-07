//
//  CharacterListView.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {
        NavigationStack {
            ZStack {
                List(viewModel.filteredCharacters) { character in
                    NavigationLink(value: character.id) {
                        CharacterRow(character: character)
                            .onAppear {
                                if viewModel.characters.last == character {
                                    viewModel.fetchCharacters()
                                }
                            }
                    }
                }
                .searchable(text: $viewModel.searchText)
                .navigationTitle("Characters")
                .navigationDestination(for: Int.self) { characterID in
                    CharacterDetailView(
                        viewModel: CharacterDetailViewModel(
                            repository: CharacterRepository(),
                            characterID: characterID
                        )
                    )
                }
                if viewModel.isLoading {
                    LoadingView()
                        .frame(width: 180, height: 180)
                }
            } // end ZStack
        } // end NavigationStack
    }
}

#Preview("Character List View") {
    let coordinator = AppCoordinator()
    let mockCharacters = [
        Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationInfo(name: "Earth (C-137)", url: ""),
            location: LocationInfo(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode: [],
            url: "",
            created: ""
        ),
        Character(
            id: 2,
            name: "Morty Smith",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: LocationInfo(name: "Earth (C-137)", url: ""),
            location: LocationInfo(name: "Citadel of Ricks", url: ""),
            image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
            episode: [],
            url: "",
            created: ""
        )
    ]

    let viewModel = CharacterListViewModel()
    viewModel.characters = mockCharacters

    return CharacterListView()
        .environmentObject(coordinator)
        .environmentObject(viewModel)
}
