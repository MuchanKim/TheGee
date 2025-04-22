//
//  BackgroundModifiers.swift
//  TheGee
//
//  Created by Moo on 4/22/25.
//

import SwiftUI

struct CaveBackgroundModifier: ViewModifier {
    var opacity: CGFloat = 0.95
    
    func body(content: Content) -> some View {
        ZStack {
            Image("Cave")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(opacity)
            
            content
        }
    }
}
