//
//  View+Background.swift
//  TheGee
//
//  Created by Moo on 4/22/25.
//

import SwiftUI

extension View {
    func caveBackground(opacity: CGFloat = 0.95) -> some View {
        self.modifier(CaveBackgroundModifier(opacity: opacity))
    }
}
