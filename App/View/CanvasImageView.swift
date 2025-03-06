//
//  CanvasImageView.swift
//  Just Pencil
//
//  Created by ymy on 3/6/25.
//

import Foundation
import SwiftUI

struct CanvasImageView: View {
    @Binding var showSourceDialog: Bool
    @Binding var showImagePicker: Bool
    @Binding var selectedImage: UIImage?
    @Binding var canvasImages: [CanvasImage]  // 캔버스에 그릴 이미지들
    
    var body: some View {
        ForEach($canvasImages, id: \.id) { $item in
            // 삽입된 UIImage를 SwiftUI 이미지로 표시
            Image(uiImage: item.image!)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 300, maxHeight: 300)  // **필요시 크기 제한** (예: 최대 300x300)
                .offset(item.offset)
                .scaleEffect(item.scale)
                .rotationEffect(item.rotation)
            // 제스처: 드래그 + 핀치 + 회전을 동시에 인식
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            // Corrected: Manually add width and height
                            item.offset = CGSize(
                                width: item.lastOffset.width + value.translation.width,
                                height: item.lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { _ in
                            // Save final position for next gesture
                            item.lastOffset = item.offset
                        }
                        .simultaneously(with: MagnificationGesture()
                            .onChanged { value in
                                // 현재 스케일 = 기존 스케일 * 핀치 비율
                                item.scale = item.lastScale * value
                            }
                            .onEnded { _ in
                                item.lastScale = item.scale
                            })
                        .simultaneously(with: RotationGesture()
                            .onChanged { value in
                                // 현재 각도 = 기존 각도 + 회전 변화량
                                item.rotation = item.lastRotation + value
                            }
                            .onEnded { _ in
                                item.lastRotation = item.rotation
                            })
                )
            // 길게 눌러 컨텍스트 메뉴 표시 - Delete 버튼
                .contextMenu {
                    Button(role: .destructive) {
                        // 해당 이미지를 배열에서 제거하여 삭제
                        canvasImages.removeAll { $0.id == item.id }
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
        }
    }
}
