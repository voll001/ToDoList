//
//  NoteModel.swift
//  LearnToDoList
//
//  Created by Оля on 15.02.2021.
//

import UIKit

struct Note {
    enum Priority: String, CaseIterable {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
        
        var priorityColor: UIColor {
            switch self {
            case .high:
                return .systemRed
            case .medium:
                return .systemOrange
            case .low:
                return .systemGray
            }
        }
    }
    
    var title: String
    var description: String?
    var priority: Priority
    var date: Date
}
