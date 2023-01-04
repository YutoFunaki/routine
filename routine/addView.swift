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
                    ZStack{
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 50,height: 30)
                        Text("確定")
                            .foregroundColor(.white)
                    }
                }
                Spacer()
            }
            .navigationTitle("追加")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button(action: {
                        isPresented = true
                    }) {
                        Text("キャンセル")
                    }
                    .fullScreenCover(isPresented: $isPresented) {
                        ContentView()
                    }
                }
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
    }
}


struct addView_Previews: PreviewProvider {
    static var previews: some View {
        addView()
    }
}
