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
    @Environment(\.colorScheme) var theme
    
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
                    HStack {
                        Text(item.title!)
                        Spacer()
                        Text(item.limitDate?.toString() ?? "")
                            .font(.subheadline)
                            .foregroundColor(item.limitDate! <= Date() ? .red : .gray)
                    }
                }
            }
            .listStyle(GroupedListStyle())
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
        .accentColor(theme == .dark ? .white:.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
            .environment(\.managedObjectContext, TodoModel.preview.container.viewContext)
    }
}
