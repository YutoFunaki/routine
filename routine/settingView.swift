//
//  settingView.swift
//  routine
//
//  Created by 船木勇斗 on 2023/01/04.
//

import SwiftUI

struct settingView: View {
    @State private var isPresented: Bool = false
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle("Setting")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarTitleDisplayMode(.large)
            
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button(action: {
                        isPresented = true
                    }) {
                        Text("変更")
                    }
                    .fullScreenCover(isPresented: $isPresented) { //フルスクリーンの画面遷移
                        ContentView()
                    }
                }
            }
            
        }
        
    }
    
    struct settingView_Previews: PreviewProvider {
        static var previews: some View {
            settingView()
        }
    }
    
    
}
