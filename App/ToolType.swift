//
//  ToolType.swift
//  Just Pencil
//
//  Created by ymy on 2/27/25.
//

import SwiftUI
import PencilKit

/// PencilKit에서 사용할 도구 종류를 열거형으로 정의
enum ToolType: String, CaseIterable {
    case pencil    // 연필
    case pen       // 펜 (만년필)
    case marker    // 형광펜/마커
    case eraser    // 지우개 (벡터 지우개)
    case lasso     // 올가미 (선택 도구)
    
    /// ToolType에 대응하는 PencilKit의 PKTool 객체 생성
    func createTool(color: UIColor, width: CGFloat, opacity: CGFloat) -> PKTool {
        let validOpacity = max(0.1, min(CGFloat(opacity), 1.0))  // 범위 제한
        let validWidth = max(1.0, min(CGFloat(width), 50.0))

        switch self {
        case .pencil:
            return PKInkingTool(.pencil, color: color.withAlphaComponent(validOpacity), width: validWidth)
        case .pen:
            return PKInkingTool(.pen, color: color.withAlphaComponent(validOpacity), width: validWidth)
        case .marker:
            return PKInkingTool(.marker, color: color.withAlphaComponent(validOpacity), width: validWidth)
        case .eraser:
            return PKEraserTool(.vector)
        case .lasso:
            return PKLassoTool()
        }
    }
    
    var displaySymbol: String {
        switch self {
        case .pencil: return "pencil.tip"
        case .pen:    return "applepencil.tip"
        case .marker: return "highlighter"
        case .eraser: return "eraser.fill"
        case .lasso:  return "lasso"
        }
    }
    
    var selectOptionName: String {
        switch self {
        case .pencil: return "Pencil"
        case .pen:    return "Pen"
        case .marker: return "Highlighter"
        case .eraser: return "Eraser"
        case .lasso:  return "lasso"
        }
    }
}
