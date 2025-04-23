import SwiftUI
import PencilKit

/// PencilKit에서 사용할 도구 종류를 열거형으로 정의
enum ToolType: String, CaseIterable {
    case pencil    // 연필
    case pen       // 펜 (만년필)
    case eraser    // 지우개 (비트맵)
//    case selection // 선택 도구 (라소)
    
    /// ToolType에 대응하는 PencilKit의 PKTool 객체 생성
    func createTool(color: UIColor, width: CGFloat, opacity: CGFloat) -> PKTool {
        let validOpacity = max(0.01, min(CGFloat(opacity), 1.0))  // 범위 제한
        let validWidth = max(1, min(CGFloat(width), 50.0))

        switch self {
        case .pencil:
            return PKInkingTool(.pencil, color: color.withAlphaComponent(validOpacity), width: validWidth)
        case .pen:
            return PKInkingTool(.pen, color: color.withAlphaComponent(validOpacity), width: validWidth)
        case .eraser:
            return PKInkingTool(.pen, color: color.withAlphaComponent(validOpacity), width: validWidth)
//        case .selection:
//            return PKInkingTool(.pen, color: .clear, width: 0)
        }
    }
    
    var displaySymbol: String {
        switch self {
        case .pencil: return "pencil.tip"
        case .pen:    return "applepencil.tip"
        case .eraser: return "eraser.fill"
//        case .selection: return "hand.point.up.fill"
        }
    }
    
    var selectOptionName: String {
        switch self {
        case .pencil: return "Pencil"
        case .pen:    return "Pen"
        case .eraser: return "Eraser"
//        case .selection: return "Selection"
        }
    }
}
