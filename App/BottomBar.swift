//
//  BottomBar.swift
//  Just Pencil
//
//  Created by ymy on 2/27/25.
//

import SwiftUI
import PencilKit

struct BottomBarView: View {
    @Binding var canvasView: PKCanvasView
    
    var body: some View {
        HStack {
            Button(action: {
                canvasView.drawing = PKDrawing()

            }) {
                Image(systemName: "trash")
            }
            Spacer()

        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))

    }
}
