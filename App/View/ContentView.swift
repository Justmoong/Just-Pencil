//
//  ContentView.swift
//  Just Pencil
//
//  Created by ymy on 2/24/25.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    // PencilKit 캔버스와 툴피커 객체 생성
    @State private var canvasView = PKCanvasView()
    private let toolPicker = PKToolPicker()// 그림을 그릴 PKCanvasView 인스턴스
    @State private var selectedTool: ToolType = .pencil             // 현재 선택된 도구 (기본: 연필)
    @State private var brushWidth: CGFloat = 1.0                    // 브러시 두께 (1~50)
    @State private var brushOpacity: CGFloat = 0.75          // 브러시 불투명도 (0.01~1.0)
    @State private var selectedColor: Color = .black               // 선택된 색상 (기본: 검정색)
    @State private var showingSettings: Bool = false                // 설정 시트 표시 여부
    
    // 사용자가 선택하여 표시할 도구들 (쉼표로 이어진 문자열 형태로 UserDefaults에 저장)
    @AppStorage("selectedTools") private var selectedToolsString: String =
        "pencil,pen,marker,eraser,lasso"  // 기본값: 모든 도구 표시
    
    /// selectedToolsString을 Set<ToolType>으로 변환한 computed property
    @State private var selectedToolsSet: Set<ToolType> = [.pencil, .pen, .eraser, .selection]
    
    @State private var allTools: [ToolType] = [.pencil, .pen, .eraser, .selection]
    
    @State var showSourceDialog: Bool = false
    @State var showImagePicker: Bool = false
    @State var selectedImage: UIImage?
    @State var canvasImages: [CanvasImage]  = [CanvasImage(image: UIImage())]
    @State var pickerSource: UIImagePickerController.SourceType = .photoLibrary
    
    var body: some View {
        VStack (spacing: 0) {
            TopBarView(canvasView: $canvasView, snapshotImage: UIImage(), showingSettings: $showingSettings, showSourceDialog: $showSourceDialog, showImagePicker: $showImagePicker, selectedImage: $selectedImage, pickerSource: $pickerSource, canvasImages: $canvasImages)
            Divider()
            ToolBarView(
                allTools: $allTools,
                selectedToolsSet: $selectedToolsSet,
                selectedTool: $selectedTool,
                applyTool: applyTool,  // 🔹 일반 클로저로 전달
                brushWidth: $brushWidth,
                brushOpacity: $brushOpacity,
                selectedColor: $selectedColor,
                isInkingTool: isInkingTool  // 🔹 일반 클로저로 전달
            )
            Divider()
            ZStack {
                CanvasImageView(showSourceDialog: $showSourceDialog, showImagePicker: $showImagePicker, selectedImage: $selectedImage, canvasImages: $canvasImages)
                PencilCanvasView(canvasView: $canvasView, toolPicker: toolPicker)
            }
            Divider()
            BottomBarView(canvasView: $canvasView)
        }
        .onChange(of: selectedColor) { _ in
            applyTool(selectedTool)
        }
        .sheet(isPresented: $showingSettings) {
                    // 설정 시트: 사용 가능한 도구 목록을 Toggle로 선택
                    PreferenceView(selectedToolsString: $selectedToolsString)
                }
    }
    
    /// 현재 선택된 도구가 잉크형 도구(펜, 연필, 형광펜)인지 검사
     private func isInkingTool(_ tool: ToolType) -> Bool {
         return tool == .pencil || tool == .pen || tool == .eraser
     }
     
    private func applyTool(_ tool: ToolType) {
        let newTool: PKTool

        switch tool {
        case .eraser:
            newTool = PKEraserTool(.fixedWidthBitmap, width: brushWidth)
        case .selection:
            newTool = PKInkingTool(.pen, color: .clear, width: 0)
        default:
            newTool = tool.createTool(color: UIColor(selectedColor), width: brushWidth, opacity: brushOpacity)
        }

        canvasView.tool = newTool
    }
    
    
}

#Preview {
    ContentView(canvasImages: [CanvasImage(image: UIImage(named: "image1")!), CanvasImage(image: UIImage(named: "image2")!)])
}
