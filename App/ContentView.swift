//
//  ContentView.swift
//  Just Pencil
//
//  Created by ymy on 2/24/25.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    // PencilKit 캔버스와 툴피커 객체 생성
    @State private var canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()
    
    var body: some View {
        VStack{
            TopBarView(canvasView: $canvasView, snapshotImage: UIImage())
            PencilCanvasView(canvasView: $canvasView, toolPicker: toolPicker)
            BottomBarView(canvasView: $canvasView)
        }
    }
}

#Preview {
    ContentView()
}
