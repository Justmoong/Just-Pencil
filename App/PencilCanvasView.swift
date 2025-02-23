import PencilKit
import SwiftUI

struct PencilCanvasView: UIViewRepresentable {

  @Binding var canvasView: PKCanvasView

  func makeUIView(context: Context) -> PKCanvasView {
    canvasView.drawingPolicy = .anyInput
    return canvasView
  }

  func updateUIView(_ uiView: PKCanvasView, context: Context) {

  }
}
