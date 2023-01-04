//
//  ContentView.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/03.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isPresented: Bool = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    //朝
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.title!)")
                            } label: {
                                Text(item.title!)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                    .tabItem {
                        Image(systemName: "sun.haze")
                    }
                    
                    //夜
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("Item at \(item.title!)")
                            } label: {
                                Text(item.title!)
                            }
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                        ToolbarItem {
                            Button(action: addItem) {
                                Label("Add Item", systemImage: "plus")
                            }
                        }
                    }
                    .tabItem {
                        Image(systemName: "moon")
                    }
                }
                .navigationTitle("Routine")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitleDisplayMode(.large)
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button(action: {
                            isPresented = true
                        }) {
                            Image(systemName: "gear")
                        }
                        .fullScreenCover(isPresented: $isPresented) { //フルスクリーンの画面遷移
                            settingView()
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing){
                        Button(action: {}) {
                            Image(systemName: "plus.app")
                        }
                    }
                }
            }
        }
        
    }
    
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.title = String()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct setting: View{
    var body: some View {
        settingView()
    }
}
