//
//  WorkAroundLink.swift
//  Vocabos
//
//  Created by Sinan Tanrıkut on 27.11.2023.
//

import SwiftUI

struct WorkaroundLink<Destination: View>: View {
    let destination: Destination
    let isActive: Binding<Bool>
    let isDetailLink: Bool
    
    var body: some View {
        List {
            NavigationLink(
                destination: destination,
                isActive: isActive,
                label: { EmptyView() }
            )
            .isDetailLink(isDetailLink)
        }.opacity(0.01)
    }
}

extension View {
    func workaroundLink<D: View>(to destination: D, isActive: Binding<Bool>, isDetailLink: Bool = false) -> some View {
        background(WorkaroundLink(destination: destination, isActive: isActive, isDetailLink: isDetailLink))
    }
}
