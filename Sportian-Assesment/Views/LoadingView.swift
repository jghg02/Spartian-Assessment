//
//  LoadingView.swift
//  Sportian-Assesment
//
//  Created by Josue Hernandez on 2024-11-07.
//

import SwiftUI

struct LoadingView: View {
    @State private var isAnimating = false
    @State private var trimEnd: CGFloat = 0.8 // Initial trim value

    var body: some View {
        VStack {
            Circle()
                .trim(from: 0, to: trimEnd)
                .stroke(
                    AngularGradient(gradient: Gradient(colors: [.blue, .purple, .blue]), center: .center),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round)
                )
                .frame(width: 50, height: 50)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .animation(
                    Animation.linear(duration: 1).repeatForever(autoreverses: false),
                    value: isAnimating
                )
        }
        .onAppear {
            isAnimating = true
            startRandomTrimAnimation()
        }
    }

    private func startRandomTrimAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            withAnimation(.easeInOut(duration: 0.5)) {
                // Generate a random trim end between 0.5 and 1.0
                trimEnd = CGFloat.random(in: 0.5...1.0)
            }
        }
    }
}

#Preview {
    LoadingView()
}
