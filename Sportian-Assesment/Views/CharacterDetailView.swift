//
//  CharacterDetailView.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import SwiftUI

struct CharacterDetailView: View {
    @StateObject var viewModel: CharacterDetailViewModel

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let character = viewModel.character {
                VStack {
                    AsyncImage(url: URL(string: character.image)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())

                    Text(character.name)
                        .font(.largeTitle)

                    Text("Status: \(character.status)")
                        .foregroundColor(character.status == "Alive" ? .green : .red)

                    Text("Species: \(character.species)")
                    Text("Gender: \(character.gender)")
                    Text("Origin: \(character.origin.name)")
                    Text("Location: \(character.location.name)")
                }
                .padding()
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
            }
        }
        .navigationTitle(viewModel.character?.name ?? "Character Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}
