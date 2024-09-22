//
//  DropdownOffsetPreferenceKey.swift
//  Dropdown Task
//
//  Created by Astghik Hakopian on 04.12.23.
//

import SwiftUI

struct DropdownOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
