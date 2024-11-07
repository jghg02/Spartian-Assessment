//
//  NetworkManager.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import NET
import Foundation

class NetworkManager {
    private let baseURL = "https://rickandmortyapi.com/api/character"
    private let characterListClient = NETClient<APIResponse, CharacterError>()
    private let singleCharacterClient = NETClient<Character, CharacterError>()

    func fetchCharacters(page: Int) async throws -> APIResponse {
        guard let url = URL(string: "\(baseURL)?page=\(page)") else {
            throw URLError(.badURL)
        }

        let request = NETRequest(url: url)

        switch await characterListClient.request(request) {
        case .success(let response):
            return response.value
        case .failure(let error):
            throw error
        }
    }

    func fetchCharacter(by id: Int) async throws -> Character {
        guard let url = URL(string: "\(baseURL)/\(id)") else {
            throw URLError(.badURL)
        }

        let request = NETRequest(url: url)

        switch await singleCharacterClient.request(request) {
        case .success(let character):
            return character.value
        case .failure(let error):
            throw error
        }
    }
}
