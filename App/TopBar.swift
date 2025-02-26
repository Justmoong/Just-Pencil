//
//  TopBar.swift
//  Just Pencil
//
//  Created by ymy on 2/27/25.
//

import SwiftUI
import PencilKit

struct TopBarView: View {
    @Binding var canvasView: PKCanvasView
    @State var showShareSheet = false
    @State var snapshotImage: UIImage
    
    var body: some View {
        
        
        HStack {
            Spacer()
            Button(action: {
                self.snapshotImage = renderImage()
                    self.showShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
            }
            .sheet(isPresented: $showShareSheet) {
                let image = renderImage()
                    ShareSheet(items: [image])
                
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))

    }
    
    private func renderImage() -> UIImage {
        return canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
    }
}
