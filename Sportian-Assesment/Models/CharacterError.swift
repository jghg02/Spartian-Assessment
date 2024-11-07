//
//  CharacterError.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import Foundation

// Define a custom error to handle network errors
struct CharacterError: LocalizedError, Codable, Equatable {
    let status: Int
    let message: String

    var errorDescription: String? { message }
}
