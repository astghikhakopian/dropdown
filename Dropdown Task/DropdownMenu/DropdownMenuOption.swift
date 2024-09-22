//
//  DropdownMenuOption.swift
//  Dropdown Task
//
//  Created by Astghik Hakopian on 04.12.23.
//

enum DropdownMenuOption: CaseIterable {
    
    case option1, option2, option3, option4, option5, option6, option7
    
    var title: String {
        switch self {
        case .option1:
            return "Opinion 1"
        case .option2:
            return "Opinion 2"
        case .option3:
            return "Opinion 3"
        case .option4:
            return "Opinion 4"
        case .option5:
            return "Opinion 5"
        case .option6:
            return "Opinion 6"
        case .option7:
            return "Opinion 7"
        }
    }
}
