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
    @Binding var showingSettings: Bool  // 설정 시트 표시 여부
    
    var body: some View {
        
        
        HStack {
            Button(action: {
                showingSettings.toggle()
            }) {
                Image(systemName: "gear")
                    .imageScale(.large)
            }
            Spacer()
            Button(action: {
                self.snapshotImage = renderImage()
                self.showShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
                    .imageScale(.large)

            }
            .sheet(isPresented: $showShareSheet, onDismiss: {
            }) {
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
