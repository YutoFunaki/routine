//
//  ContentView.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/03.
//

import SwiftUI
import CoreData
import GoogleMobileAds
import UIKit
import Foundation

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isPresented: Bool = false
    private let dateFormatter = DateFormatter()
    private let center = UNUserNotificationCenter.current()
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.title, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    init(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: .alert) { granted, error in
            if granted {
                print("許可されました！")
            }else{
                print("拒否されました...")
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView {
                    
                    //朝
                    List {
                        ForEach(items) { item in
                            NavigationLink {
                                Text("やること　\(item.title!)")
                                Text("開始時刻　\(item.startTime!)")
                                Text("終了時刻　\(item.finishTime!)")
                                
                            } label: {
                                Text(item.title!)
                            }
                        }
                        .onDelete(perform: deleteItems)
                        
                    }
                    .tabItem {
                        Image(systemName: "sun.haze")
                    }
                    //夜
                    
                }
                
                //BannerAdView().frame(width: 320, height: 50)
                .navigationTitle("Routine")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarTitleDisplayMode(.large)
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: addView()) {
                            Text("追加")
                        }
                    }
                }
            }
        }
        
    }
    
    
    
    //リストを削除する関数
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)
            
            do {
                center.removePendingNotificationRequests(withIdentifiers: ["\(startTime)"])
                center.removePendingNotificationRequests(withIdentifiers: ["\(\Item.finishTime)"])
                print((\Item.title))
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





//settingView(没案)
struct setting: View{
    var body: some View {
        settingView()
    }
}


struct add: View{
    var body: some View {
        addView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
