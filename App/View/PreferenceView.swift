//
//  ToolSelectionView.swift
//  Just Pencil
//
//  Created by ymy on 2/27/25.
//

import Foundation
import SwiftUI
import PencilKit

struct PreferenceView: View {
    @Binding var selectedToolsString: String  // AppStorage로부터 바인딩된 선택 도구 문자열
    
    // PencilKit의 모든 도구 (순서는 ToolType 정의 순서를 따름)
    private let allTools = ToolType.allCases
    
    @Environment(\.presentationMode) var presentationMode  // 시트 닫기 제어용 환경변수
    
    var body: some View {
        NavigationView {
            List {
                // 각 도구별 Toggle를 생성
                ForEach(allTools, id: \.self) { tool in
                    Toggle(tool.selectOptionName, isOn: bindingForTool(tool))
                }
            }
            .navigationBarTitle("Select Tools", displayMode: .inline)
            .navigationBarItems(trailing: Button("Done") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
    
    /// 각 도구별 Toggle를 위한 Binding<Bool> 생성
    private func bindingForTool(_ tool: ToolType) -> Binding<Bool> {
        return Binding<Bool>(
            get: {
                // 선택된 도구 문자열에 현재 툴의 rawValue가 포함되어 있는지 확인
                let tools = selectedToolsString.split(separator: ",").map { String($0) }
                return tools.contains(tool.rawValue)
            },
            set: { isOn in
                // 토글 변경에 따라 selectedToolsString 업데이트
                var tools = selectedToolsString.split(separator: ",").map { String($0) }
                if isOn {
                    // 켜졌으면 목록에 추가 (이미 존재하지 않을 때만 추가)
                    if !tools.contains(tool.rawValue) {
                        tools.append(tool.rawValue)
                    }
                } else {
                    // 꺼졌으면 목록에서 제거
                    tools.removeAll(where: { $0 == tool.rawValue })
                }
                // 배열을 다시 쉼표로 이어서 저장
                selectedToolsString = tools.joined(separator: ",")
            }
        )
    }
}
