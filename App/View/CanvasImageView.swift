//
//  CanvasImageView.swift
//  Just Pencil
//
//  Created by ymy on 3/6/25.
//

import SwiftUI

struct CanvasImageView: View {
    @Binding var showSourceDialog: Bool
    @Binding var showImagePicker: Bool
    @Binding var selectedImage: UIImage?
    @Binding var canvasImages: [CanvasImage]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach($canvasImages) { $imageItem in
                    Image(uiImage: imageItem.image!)
                        .resizable()
                        .scaledToFit() // ✅ 이미지가 캔버스를 채우도록 변경
                        .frame(width: geometry.size.width, height: geometry.size.height) // ✅ 캔버스 크기에 맞춤
                        .clipped() // ✅ 넘치는 부분 잘라내기
                        .rotationEffect(imageItem.rotation) // ✅ 회전 적용
                        .offset(imageItem.offset) // ✅ 위치 적용
                        .contextMenu {
                            Button(role: .destructive) {
                                canvasImages.removeAll { $0.id == imageItem.id } // ✅ 삭제 기능 추가
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // ✅ 캔버스 크기 고정
        }
    }
}
