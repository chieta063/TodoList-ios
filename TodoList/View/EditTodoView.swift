//
//  SubView.swift
//  TodoList
//
//  Created by 阿部紘明 on 2020/09/28.
//

import SwiftUI

struct EditTodoView: View {
    @ObservedObject var model: TodoModel
    @Environment(\.presentationMode) var mode
    @Environment(\.colorScheme) var theme
    
    @State var todoTitle: String = ""
    @State var limitDate: Date = Date()
    
    @State var errorMessage: String = ""
    @State var isPresentError: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("やることを入力", text: $todoTitle)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                DatePicker("締め切り", selection: $limitDate, displayedComponents: .date)
                    .datePickerStyle(DefaultDatePickerStyle())
                    .padding()
                    .pickerStyle(InlinePickerStyle())
                Spacer()
                Button(action: {
                    if todoTitle.isEmpty {
                        isPresentError.toggle()
                        errorMessage = "タイトルを入力してね"
                    } else {
                        model.addData(title: todoTitle, limit: limitDate) { (error) in
                            if let error = error {
                                errorMessage = error.localizedDescription
                                isPresentError.toggle()
                            } else {
                                mode.wrappedValue.dismiss()
                            }
                        }
                        mode.wrappedValue.dismiss()
                    }
                }, label: {
                    HStack {
                        Image(systemName: "paperplane")
                        Text("作成")
                    }
                    .padding(EdgeInsets(top: 10.0, leading: 32.0, bottom: 10.0, trailing: 32.0))
                    .background(Color.blue)
                    .cornerRadius(25.0)
                })
                .alert(isPresented: $isPresentError, content: {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                })
                .accentColor(.white)
                .padding(.all, 8)
            }
            .toolbar(content: {
                Button(action: {
                    mode.wrappedValue.dismiss()
                }, label: {
                    Label("Close", systemImage: "xmark")
                })
            })
            .navigationBarTitle("Todo作成", displayMode: .inline)
        }
        .accentColor(theme == .dark ? .white:.black)
    }
}

struct SubView_Previews: PreviewProvider {
    static var previews: some View {
        
        EditTodoView(model: TodoModel.shared)
            .environment(\.locale, Locale(identifier: "ja_JP"))
    }
}
