//
//  DropdownMenu.swift
//  Dropdown Task
//
//  Created by Astghik Hakopian on 04.12.23.
//

import SwiftUI

struct DropdownMenu: View {
    
    enum Style { case top, bottom }
    
    
    // MARK: - Public Properties
    
    @Binding var selectedOption: DropdownMenuOption?
    
    let placeholder: String
    let options: [DropdownMenuOption]
    
    
    // MARK: - Private Properties
    
    @State private var isOpen: Bool = false
    @State private var itemOffset: CGFloat = 0
    
    // computing
    private var title: String {
        selectedOption?.title ?? placeholder
    }
    private var textColor: Color {
        selectedOption == nil ? .secondary : .primary
    }
    private var rightImage: Image {
        Image(systemName: isOpen ? "chevron.up" : "chevron.down")
    }
    private var menuHeight: CGFloat {
        (optionHeight+optionSpacing)*CGFloat(min(options.count, maxVisibleOptionsCount)) - optionSpacing
    }
    private var style: Style {
        itemOffset > UIScreen.main.bounds.height - menuHeight - contentSpacing - contentHeight ? .top : .bottom
    }
    private var menuOffset: CGFloat {
        switch style {
        case .top:
            return -menuHeight-contentSpacing
        case .bottom:
            return contentHeight
        }
    }
    
    // configuration
    private let maxVisibleOptionsCount = 4
    private let optionHeight: CGFloat = 48
    private let optionSpacing: CGFloat = 0
    private let contentHeight: CGFloat = 64
    private let contentSpacing: CGFloat = 8
    private let cornerRadius: CGFloat = 16
    
    
    var body: some View {
        Button {
            isOpen.toggle()
        } label: {
            content
                .background(GeometryReader {
                    Color.clear.preference(
                        key: DropdownOffsetPreferenceKey.self,
                        value: $0.frame(in: .global).minY
                    )
                })
                .onPreferenceChange(DropdownOffsetPreferenceKey.self) {
                    itemOffset = $0
                }
        }
        .overlay(alignment: .top) {
            VStack {
                if isOpen {
                    menuList(options: options) { option in
                        isOpen = false
                        selectedOption = option
                    }
                    .padding(.top, menuOffset)
                }
            }
        }
        .zIndex(1)
    }
}


// MARK: - Components

private extension DropdownMenu {
    
    private var content: some View {
        HStack {
            Text(title)
                .foregroundColor(textColor)
            Spacer()
            rightImage
                .foregroundColor(.black)
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(.gray, lineWidth: 1)
        }
    }
    
    private func menuList(
        options: [DropdownMenuOption],
        onSelectedAction: @escaping (_ option: DropdownMenuOption) -> Void
    ) -> some View {
        ScrollView {
            LazyVStack(spacing: optionSpacing) {
                ForEach(options, id: \.self) { option in
                    Button {
                        onSelectedAction(option)
                    } label: {
                        HStack {
                            Text(option.title)
                                .foregroundColor(.primary)
                                .fontWeight(selectedOption == option ? .bold : .regular)
                            Spacer()
                        }
                        .padding()
                        .frame(height: optionHeight)
                    }
                }
            }
        }
        .frame(height: menuHeight)
        .padding(.vertical, optionSpacing)
        .background(.white)
        .cornerRadius(cornerRadius)
        .overlay {
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(.gray, lineWidth: 1)
        }
    }
}


#Preview {
    DropdownMenu(
        selectedOption: .constant(nil),
        placeholder: "Select your option",
        options: DropdownMenuOption.allCases
    )
}
