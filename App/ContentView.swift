//
//  ContentView.swift
//  Just Pencil
//
//  Created by ymy on 2/24/25.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    
    var body: some View {

        VStack() {
            PencilCanvasContentView()
        }
        .toolbar {
            ToolbarItem {
                HStack {
                    Button(action: {
                        print("Undo")
                    }) {
                        Image(systemName: "arrow.uturn.backward")
                    }
                    Button(action: {
                        print("Redo")
                    }) {
                        Image(systemName: "arrow.uturn.forward")
                    }
                    Spacer()
                    Button(action: {
                        print("Clear")
                    }) {
                        Image(systemName: "trash")
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
