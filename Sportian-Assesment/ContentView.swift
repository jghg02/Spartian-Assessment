//
//  ContentView.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-10-21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var coordinator = AppCoordinator()

    var body: some View {
        CharacterListView()
            .environmentObject(coordinator)
    }
}
