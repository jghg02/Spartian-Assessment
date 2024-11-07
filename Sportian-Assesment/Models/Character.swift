//
//  Character.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-06.
//

import Foundation

struct Character: Identifiable, Codable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: LocationInfo
    let location: LocationInfo
    let image: String
    let episode: [String]
    let url: String
    let created: String
}

struct LocationInfo: Codable, Equatable {
    let name: String
    let url: String
}
