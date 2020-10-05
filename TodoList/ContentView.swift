//
//  ContentView.swift
//  TodoList
//
//  Created by 阿部紘明 on 2020/09/28.
//

import SwiftUI

struct TodoListView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var isPresent: Bool = false
    @Environment(\.timeZone) private var timeZone
    
    @FetchRequest(fetchRequest: TodoModel.fetchRequest)
    private var todos: FetchedResults<Todo>
    
    private var formatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.timeZone = timeZone
        return formatter
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos) { item in
                    NavigationLink(
                        destination: Text(item.title!),
                        label: {
                            HStack {
                                Text(item.title!)
                                Spacer()
                            }
                        }
                    )
                }
            }
            .listStyle(PlainListStyle())
            .toolbar(content: {
                Button(action: {
                    isPresent.toggle()
                }, label: {
                    Label("Add", systemImage: "plus")
                })
            })
            .fullScreenCover(isPresented: $isPresent, content: {
                EditTodoView(model: TodoModel.shared)
            })
            .navigationBarTitle("やること", displayMode: .inline)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environment(\.managedObjectContext, TodoModel.preview.container.viewContext)
    }
}
