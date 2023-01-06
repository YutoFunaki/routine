//
//  addView.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/04.
//

import SwiftUI
import CoreData

struct addView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var isPresented: Bool = false
    @State private var title = ""
    @State private var startTime = Date()
    @State private var finishTime = Date()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                TextField("やること", text: $title)
                    .padding()
                
                Spacer()
                
                DatePicker("開始時刻", selection: $startTime, displayedComponents: .hourAndMinute)
                    .padding()
                Spacer()
                DatePicker("終了時刻", selection: $finishTime, displayedComponents: .hourAndMinute)
                    .padding()
                Spacer()
                
            }
            .environment(\.editMode, .constant(.active))
            .navigationTitle("追加")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addItem()
                        sendNotificationRequest()
                    }) {
                        Text("保存")
                    }
                }
            }
        }
    }
    
    //通知のやつ
    func sendNotificationRequest(){
        let content = UNMutableNotificationContent()
        content.title = "\(title)の開始時刻です"
        content.body = "頑張りましょう！"
        
        let dateComponent = Calendar.current.dateComponents([.hour,.minute], from: startTime)
        print(dateComponent)  // 以下に表示
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendNotificationRequest2(){
        let content = UNMutableNotificationContent()
        content.title = "\(title)の終了時刻です"
        content.body = "お疲れ様でした！"
        
        let dateComponent = Calendar.current.dateComponents([.hour,.minute], from: finishTime)
        print(dateComponent)  // 以下に表示
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    //リストを追加する関数
    private func addItem() {
        let newItem = Item(context: viewContext)
        newItem.title = title
        newItem.startTime = startTime
        newItem.finishTime = finishTime
        
        try? viewContext.save()
        presentation.wrappedValue.dismiss()
    }
    
    
    
    struct addView_Previews: PreviewProvider {
        static var previews: some View {
            addView()
        }
    }
}
