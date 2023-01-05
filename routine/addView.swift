//
//  addView.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/04.
//

import SwiftUI

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
                    
                DatePicker("終了時刻", selection: $startTime, displayedComponents: .hourAndMinute)
                .padding()
                Spacer()
            }
            .navigationTitle("追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {addItem()}) {
                        Text("保存")
                    }
                }
            }
            .fullScreenCover(isPresented: $isPresented) {
                ContentView()
            }
        }
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
