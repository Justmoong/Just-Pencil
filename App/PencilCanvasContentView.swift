import PencilKit
import SwiftUI

struct CanvasContentView: View {
  @State private var canvasView = PKCanvasView()
  @State private var toolPicker = PKToolPicker()

  var body: some View {
    VStack {
      PencilCanvasView(canvasView: $canvasView)
        .onAppear {
          if let window = UIApplication.shared.windows.first {
            toolPicker.setVisible(true, forFirstResponder: canvasView)
            toolPicker.addObserver(canvasView)
            canvasView.becomeFirstResponder()
          }
        }
        .background(Color.white)
    }
  }

}

#Preview {
  CanvasContentView()
}
