//
//  Tasks.swift
//  TodoList
//
//  Created by tamires.p.silva on 18/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import UIKit

struct Tasks {
    let type: ModelType
    let descTask: String
    let date: Date
    
    enum ModelType {
        case onPriority, daily, home
        
        var typeDescription: String{
            switch self {
            case .onPriority:
                return "ON PRIORITY"
            case .daily:
                return "DAILY"
            case .home:
                return "HOME"
            }
        }
        
        var typeColor: UIColor? {
            switch self {
            case .onPriority:
                return UIColor(named: "on_priority_color")
            case .daily:
                return UIColor(named: "daily_color")
            case .home:
                return UIColor(named: "home_color")
            }
        }
        
    }
}
