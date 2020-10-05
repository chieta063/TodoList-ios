//
//  TodoListApp.swift
//  TodoList
//
//  Created by 阿部紘明 on 2020/09/28.
//

import SwiftUI

@main
struct TodoListApp: App {
    let todoModel = TodoModel.shared
    
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environment(\.managedObjectContext, todoModel.container.viewContext)
        }
    }
}
