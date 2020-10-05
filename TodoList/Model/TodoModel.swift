//
//  UserData.swift
//  TodoList
//
//  Created by 阿部紘明 on 2020/09/28.
//

import Foundation
import CoreData

class TodoModel: ObservableObject {
    static let shared = TodoModel()
    
    static var fetchRequest: NSFetchRequest<Todo> {
        let request: NSFetchRequest<Todo> = Todo.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Todo.limitDate, ascending: true)]
        return request
    }
    
    static var preview: TodoModel {
        let model = TodoModel(inMemory: true)
        let viewContext = model.container.viewContext
        viewContext.reset()
        for i in 0..<10 {
            let item = Todo(context: viewContext)
            item.title = "Todo \(i + 1)"
            item.limitDate = Date()
        }
        do {
            try viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
        return model
    }
    
    let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "TodoList")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Error \(error), \(error.userInfo)")
            }
        }
    }
    
    func addData(title: String, limit: Date, completion: (_ error: Error? ) -> Void) {
        let todo = Todo(context: container.viewContext)
        todo.title = title
        todo.limitDate = limit
        do {
            try container.viewContext.save()
            completion(nil)
        } catch {
            completion(error)
        }
    }
}
