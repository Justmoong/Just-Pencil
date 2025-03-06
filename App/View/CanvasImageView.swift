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
        ZStack {
            ForEach($canvasImages) { $imageItem in
                Image(uiImage: imageItem.image!)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 200 * imageItem.scale,
                        height: 200 * imageItem.scale
                    ) // ✅ 크기 적용
                    .rotationEffect(imageItem.rotation) // ✅ 회전 적용
                    .offset(imageItem.offset) // ✅ 위치 적용
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                imageItem.offset = CGSize(
                                    width: imageItem.lastOffset.width + value.translation.width * imageItem.scale, // ✅ 크기에 따른 감도 조정
                                    height: imageItem.lastOffset.height + value.translation.height * imageItem.scale
                                )
                            }
                            .onEnded { _ in
                                imageItem.lastOffset = imageItem.offset
                            }
                            .simultaneously(with:
                                MagnificationGesture()
                                    .onChanged { value in
                                        imageItem.scale = max(0.3, min(value * imageItem.lastScale, 4.0)) // ✅ 크기 제한
                                    }
                                    .onEnded { _ in
                                        imageItem.lastScale = imageItem.scale
                                    }
                            )
                            .simultaneously(with:
                                RotationGesture()
                                    .onChanged { value in
                                        imageItem.rotation = imageItem.lastRotation + value
                                    }
                                    .onEnded { _ in
                                        imageItem.lastRotation = imageItem.rotation
                                    }
                            )
                    )
                    .contentShape(Rectangle()) // ✅ 실제 크기와 터치 영역을 일치
                    .contextMenu {
                        Button(role: .destructive) {
                            canvasImages.removeAll { $0.id == imageItem.id } // ✅ 삭제 기능 추가
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
    }
}
