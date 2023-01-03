//
//  routineApp.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/03.
//

import SwiftUI

@main
struct routineApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
