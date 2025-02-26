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
        // 하단 우측: 캔버스 초기화 버튼
        

        HStack {
            Button(action: {
                canvasView.drawing = PKDrawing()

            }) {
                Image(systemName: "trash")
                    .frame(width: 24, height: 24)
                    .scaledToFit()
            }
            Spacer()

        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))

    }
}
