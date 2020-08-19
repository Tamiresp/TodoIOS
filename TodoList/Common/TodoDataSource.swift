//
//  TodoDataSource.swift
//  TodoList
//
//  Created by tamires.p.silva on 18/08/20.
//  Copyright © 2020 Tamires. All rights reserved.
//

import Foundation

final class TodoDataSource {
    static let share = TodoDataSource()
    
    private init() {}
    
    var todos: [Tasks] = [
        Tasks(type: .daily, descTask: "Teste", date: Date()),
        Tasks(type: .home, descTask: "Teste2", date: Date()),
        Tasks(type: .onPriority, descTask: "Teste3", date: Date()),
        Tasks(type: .onPriority, descTask: "Teste4", date: Date()),
        Tasks(type: .daily, descTask: "Teste5", date: Date()),
        Tasks(type: .home, descTask: "Teste6", date: Date()),
        Tasks(type: .daily, descTask: "Teste7", date: Date())
    ]
}
