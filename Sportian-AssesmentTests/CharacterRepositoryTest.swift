//
//  CharacterRepositoryTest.swift
//  Sportian-AssesmentTests
//
//  Created by Josue Hernandez on 2024-11-07.
//

import XCTest
import CoreData
@testable import Sportian_Assesment

// Mock NetworkManager to simulate network responses
class MockNetworkManager {
    var shouldReturnError = false
    var mockCharacters: [Character] = []
    var mockCharacter: Character?

    func fetchCharacters(page: Int) async throws -> APIResponse {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return APIResponse(results: mockCharacters)
    }

    func fetchCharacter(by id: Int) async throws -> Character {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return mockCharacter!
    }
}

class CharacterRepositoryTests: XCTestCase {
    var mockNetworkManager: MockNetworkManager!
    var repository: CharacterRepository!
    var context: NSManagedObjectContext!

    override func setUp() {
        super.setUp()

        // Initialize the in-memory Core Data stack
        let persistentContainer = NSPersistentContainer(name: "Sportian_Assessment")
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        persistentContainer.persistentStoreDescriptions = [description]
        persistentContainer.loadPersistentStores { (_, error) in
            XCTAssertNil(error)
        }

        context = persistentContainer.viewContext

        // Initialize the mock network manager and repository
        mockNetworkManager = MockNetworkManager()
        repository = CharacterRepository()
    }

    override func tearDown() {
        mockNetworkManager = nil
        repository = nil
        context = nil
        super.tearDown()
    }

    func testFetchCharactersFromNetworkWhenCacheIsEmpty() async throws {
        // Ensure Core Data is empty
        let fetchRequest: NSFetchRequest<CachedCharacterModel> = CachedCharacterModel.fetchRequest()
        let cachedCharacters = try context.fetch(fetchRequest)
        XCTAssertTrue(cachedCharacters.isEmpty, "Expected Core Data to be empty at the start of the test.")
    }

    func testFetchCharactersFromNetworkAndCache() async throws {
        // Prepare mock data
        // swiftlint:disable:next line_length
        let character = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        mockNetworkManager.mockCharacters = [character]

        // Fetch characters - should call network and cache the result
        let characters = try await repository.fetchCharacters(page: 1)
        XCTAssertEqual(characters.count, 10)
        XCTAssertEqual(characters.first?.name, "Adjudicator Rick")

        // Fetch characters again - should return cached result
        let cachedCharacters = repository.fetchCachedCharacters(for: 1)
        XCTAssertEqual(cachedCharacters?.count, 10)
        XCTAssertEqual(cachedCharacters?.first?.name, "Adjudicator Rick")
    }

    func testFetchCharacterByIdFromNetwork() async throws {
        // swiftlint:disable:next line_length
        let character = Character(id: 1, name: "Morty Smith", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        mockNetworkManager.mockCharacter = character

        // Fetch character by ID - should call network
        let fetchedCharacter = try await repository.fetchCharacter(by: 1)
        XCTAssertEqual(fetchedCharacter.name, "Rick Sanchez")
    }

    func testSaveCharactersToCache() throws {
        // swiftlint:disable:next line_length
        let character = Character(id: 2, name: "Summer Smith", status: "Alive", species: "Human", type: "", gender: "Female", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")

        // Save to cache
        repository.saveCharactersToCache([character], for: 1)

        // Fetch from cache
        let cachedCharacters = repository.fetchCachedCharacters(for: 1)
        XCTAssertEqual(cachedCharacters?.count, 10)
        XCTAssertEqual(cachedCharacters?.first?.name, "Adjudicator Rick")
    }

    func testFetchCharactersUsesCacheWhenAvailable() async throws {
        // swiftlint:disable:next line_length
        let character = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", type: "", gender: "Male", origin: LocationInfo(name: "Earth", url: ""), location: LocationInfo(name: "Earth", url: ""), image: "", episode: [], url: "", created: "")
        repository.saveCharactersToCache([character], for: 1)

        // Fetch characters - should use cache, not network
        mockNetworkManager.shouldReturnError = true // Simulate network failure
        let characters = try await repository.fetchCharacters(page: 1)
        XCTAssertEqual(characters.count, 10)
        XCTAssertEqual(characters.first?.name, "Adjudicator Rick")
    }
}
