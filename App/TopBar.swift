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
                // 1. 현재 그림을 UIImage로 렌더링 (스냅샷 생성)
                let drawnImage = renderImage()
                self.snapshotImage = drawnImage
                // 2. 이미지가 준비되면 공유 시트 표시
                if self.snapshotImage != nil {
                    self.showShareSheet = true
                }
            }) {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .frame(width: 24, height: 24)
                    .fixedSize()
                    .scaledToFit()
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
