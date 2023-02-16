//
//  addView.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/04.
//

import SwiftUI
import CoreData
import Foundation

struct weekDays: Hashable{
    var number: Int
}


struct addView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentation
    @State private var isPresented: Bool = false
    @State private var title = ""
    @State private var startHour = 0
    @State private var finishHour = 0
    @State private var weekDays = 0
    @State private var startMin = 0
    @State private var finishMin = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
                Spacer()
                
                TextField("やること", text: $title)
                    .padding()
                
                HStack {
                    Picker(selection: $startHour, label: Text("時")) {
                        ForEach(0 ..< 24) {i in
                            tag(i)   // .tag()の指定は不要
                        }
                    }
                    
                    Text(":")
                    
                    Picker(selection: $startMin, label: Text("分")) {
                        ForEach(0 ..< 60) {i in
                            tag(i)   // .tag()の指定は不要
                        }
                    }
                }
                //.datePickerStyle(.wheel)
                    .padding()
                //Spacer()
                HStack {
                    Picker(selection: $finishHour, label: Text("時")) {
                        ForEach(0 ..< 24) {i in
                            tag(i)   // .tag()の指定は不要
                        }
                    }
                    
                    Text(":")
                    
                    Picker(selection: $finishMin, label: Text("分")) {
                        ForEach(0 ..< 60) {i in
                            tag(i)   // .tag()の指定は不要
                        }
                    }
                }
                //.datePickerStyle(.wheel)
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
                        sendNotificationRequest2()
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
        
        let dateComponent = DateComponents(hour: startHour, minute: startMin)
        print(dateComponent)  // 以下に表示
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    func sendNotificationRequest2(){
        let content = UNMutableNotificationContent()
        content.title = "\(title)の終了時刻です"
        content.body = "お疲れ様でした！"
        
        let dateComponent = DateComponents(hour: finishHour, minute: finishMin)
        print(dateComponent)  // 以下に表示
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
    
    //リストを追加する関数
    private func addItem() {
        let newItem = Item(context: viewContext)
        newItem.title = title
        newItem.startHour = (startHour) as NSNumber
        newItem.finishHour = (finishHour) as NSNumber
        newItem.startMin = (startMin) as NSNumber
        newItem.finishMin = (finishMin) as NSNumber
        //newItem.weekDays = weekDays
        
        try? viewContext.save()
        presentation.wrappedValue.dismiss()
    }
    
    
    
    struct addView_Previews: PreviewProvider {
        static var previews: some View {
            addView()
        }
    }
}
