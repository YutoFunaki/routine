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
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                TextField("やること", text: $title)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    isPresented = true
                }){
                    
                }
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
    private func addItem(){
        let item = Item(context: viewContext)
        item.title = title
        item.updateAt = Date()
        // 生成したインスタンスをCoreDataに保存する
        try? viewContext.save()
        
        presentation.wrappedValue.dismiss()
        isPresented = true
    }
    
    
    struct addView_Previews: PreviewProvider {
        static var previews: some View {
            addView()
        }
    }
}
