//
//  CharacterRow.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import SwiftUI

struct CharacterRow: View {
    let character: Character

    var body: some View {
        HStack {
            // Character Image
            AsyncImage(url: URL(string: character.image)) { image in
                image.resizable()
            } placeholder: {
                Color.gray
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())

            // Character Info
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)

                Text(character.status)
                    .foregroundColor(character.status == "Alive" ? .green : .red)
                    .font(.subheadline)
            }

            Spacer() // Pushes arrow to the right
        }
        .padding(.vertical, 8) // Add some vertical padding for better spacing
    }
}

#Preview("Character Row") {
    CharacterRow(character: Character(
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
    ))
}
