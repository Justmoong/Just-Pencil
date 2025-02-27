//
//  ToolBarView.swift
//  Just Pencil
//
//  Created by ymy on 2/27/25.
//

import Foundation
import SwiftUI
import PencilKit


struct ToolBarView: View {
    @Binding var allTools: [ToolType]  // 전체 도구 목록
    @Binding var selectedToolsSet: Set<ToolType>  // 선택된 도구 목록
    @Binding var selectedTool: ToolType  // 현재 선택된 도구
    let applyTool: (ToolType) -> Void  // 🔹 @Binding 제거하여 일반 클로저로 변경
    @Binding var brushWidth: CGFloat  // 브러시 두께
    @Binding var brushOpacity: CGFloat  // 브러시 불투명도

    let isInkingTool: (ToolType) -> Bool  // 🔹 @Binding 제거하여 일반 클로저로 변경
    
    var body: some View {
        HStack(alignment: .center) {
            ForEach(allTools, id: \.self) { tool in
                if selectedToolsSet.contains(tool) {
                    Button(action: {
                        selectedTool = tool
                        applyTool(tool)  // 🔹 함수 실행
                    }) {
                        Image(systemName: tool.displaySymbol)
                            .padding(8)
                            .background(selectedTool == tool ? Color.gray.opacity(0.2) : Color.clear)
                            .cornerRadius(8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            Divider()
            Spacer()

            // 브러시 두께 조절 슬라이더
            HStack {
                Image(systemName: "scribble.variable")
                Slider(
                    value: $brushWidth,
                    in: 0.1...20,
                    onEditingChanged: { _ in
                        if isInkingTool(selectedTool) {  // 🔹 클로저 호출
                            applyTool(selectedTool)
                        }
                    }
                )
            }

            // 브러시 불투명도 조절 슬라이더
            HStack {
                Image(systemName: "circle.lefthalf.filled")
                Slider(
                    value: $brushOpacity,
                    in: 0.01...1.0,
                    onEditingChanged: { _ in
                        if isInkingTool(selectedTool) {  // 🔹 클로저 호출
                            applyTool(selectedTool)
                        }
                    }
                )
            }

        }
        .padding(.horizontal, 16)
        .frame(height: 50)
        .background(Color(UIColor.systemGray6))
    }
}
