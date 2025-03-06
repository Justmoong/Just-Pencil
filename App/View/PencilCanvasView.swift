import PencilKit
import SwiftUI

struct PencilCanvasView: UIViewRepresentable {

    @Binding var canvasView: PKCanvasView        // SwiftUI와 PKCanvasView 연결
        let toolPicker: PKToolPicker                // PencilKit 도구 팔레트
        
        func makeUIView(context: Context) -> PKCanvasView {
            // Pencil 전용 입력 설정
            if #available(iOS 14.0, *) {
                canvasView.drawingPolicy = .pencilOnly
            } else {
                canvasView.allowsFingerDrawing = false    // iOS 13에서는 이 속성 사용
            }
            if UIApplication.shared.connectedScenes.first is UIWindowScene {
//                toolPicker.setVisible(true, forFirstResponder: canvasView)
                toolPicker.addObserver(canvasView)
                canvasView.backgroundColor = .clear
            }
            return canvasView
        }
        
        func updateUIView(_ uiView: PKCanvasView, context: Context) {
            // 이 프로토타입에서는 특별한 업데이트 로직 불필요
            // (Binding으로 canvasView 교체 시 SwiftUI가 makeUIView를 다시 호출하여 새 캔버스 적용)
        }
}
