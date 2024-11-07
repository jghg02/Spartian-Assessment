//
//  CharacterRepository.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import Foundation
import CoreData

protocol CharacterRepositoryProtocol {
    func fetchCharacters(page: Int) async throws -> [Character]
    func fetchCharacter(by id: Int) async throws -> Character
}

class CharacterRepository: CharacterRepositoryProtocol {
    private let networkManager = NetworkManager()
    private let context = PersistenceController.shared.container.viewContext

    func fetchCharacters(page: Int) async throws -> [Character] {

        // Check if characters are cached for the given page
        if let cachedCharacters = fetchCachedCharacters(for: page), !cachedCharacters.isEmpty {
            return cachedCharacters
        }

        // Fetch from network request
        let characters = try await networkManager.fetchCharacters(page: page).results

        // Cache fetched characters
        saveCharactersToCache(characters, for: page)

        return characters
    }

    func fetchCharacter(by id: Int) async throws -> Character {
        let response = try await networkManager.fetchCharacter(by: id)
        return response
    }

    func fetchCachedCharacters(for page: Int) -> [Character]? {
        let fetchRequest: NSFetchRequest<CachedCharacterModel> = CachedCharacterModel.fetchRequest()
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = (page - 1) * 10

        do {
            let cachedEntities = try context.fetch(fetchRequest)
            print("Fectched cached characters successfully...")
            return cachedEntities.map { cachedCharacter in
                Character(
                    id: Int(cachedCharacter.id),
                    name: cachedCharacter.name ?? "",
                    status: cachedCharacter.status ?? "",
                    species: cachedCharacter.species ?? "",
                    type: cachedCharacter.type ?? "",
                    gender: cachedCharacter.gender ?? "",
                    origin: LocationInfo(name: cachedCharacter.originName ?? "", url: cachedCharacter.originUrl ?? ""),
                    // swiftlint:disable:next line_length
                    location: LocationInfo(name: cachedCharacter.locationName ?? "", url: cachedCharacter.locationUrl ?? ""),
                    image: cachedCharacter.image ?? "",
                    episode: [], // Episodes are ignored in this cache implementation for simplicity
                    url: "", // URL field can be ignored if not needed in cache
                    created: cachedCharacter.created ?? ""
                )
            }
        } catch {
            print("Failed to fetch cached characters: \(error)")
            return nil
        }
    }

    func saveCharactersToCache(_ characters: [Character], for page: Int) {
        context.perform {
            for character in characters {
                let cachedCharacter = CachedCharacterModel(context: self.context)
                cachedCharacter.id = Int32(character.id)
                cachedCharacter.name = character.name
                cachedCharacter.status = character.status
                cachedCharacter.species = character.species
                cachedCharacter.type = character.type
                cachedCharacter.gender = character.gender
                cachedCharacter.originName = character.origin.name
                cachedCharacter.originUrl = character.origin.url
                cachedCharacter.locationName = character.location.name
                cachedCharacter.locationUrl = character.location.url
                cachedCharacter.image = character.image
                cachedCharacter.created = character.created
            }

            do {
                try self.context.save()
                print("Data saved to cache successfully...")
            } catch {
                print("Failed to save characters to cache: \(error)")
            }
        }
    }
}
