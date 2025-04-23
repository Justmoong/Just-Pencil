//
//  TopBar.swift
//  Just Pencil
//
//  Created by ymy on 2/27/25.
//

import SwiftUI
import PencilKit

struct TopBarView: View {
    @Binding var canvasView: PKCanvasView
    @State var showShareSheet = false
    @State var snapshotImage: UIImage
    @Binding var showingSettings: Bool  // 설정 시트 표시 여부
    @Binding var showSourceDialog: Bool
    @Binding var showImagePicker: Bool
    @Binding var selectedImage: UIImage?
    @Binding var pickerSource: UIImagePickerController.SourceType
    @Binding var canvasImages: [CanvasImage]
    @Binding var isCanvasPhotoEmpty: Bool
    
    var body: some View {
        
        
        HStack (spacing: 16) {
            Button(action: {
                showingSettings.toggle()
            }) {
                Image(systemName: "gear")
                    .imageScale(.large)
            }
            Spacer()
            Button(action: {
                showSourceDialog.toggle()
            }) {
                Image(systemName: "plus")
                    .imageScale(.large)
                    .confirmationDialog("Select Source Image", isPresented: $showSourceDialog) {
                                Button("Take Photo") {
                                    pickerSource = .camera
                                    showImagePicker = true
                                }
                                Button("Select Photo") {
                                    pickerSource = .photoLibrary
                                    showImagePicker = true
                                }
                            }
                            // UIImagePicker 시트 표시 (selectedImage 바인딩 전달)
                            .sheet(isPresented: $showImagePicker, onDismiss: {
                                // 이미지 선택 완료 후 처리: 배열에 추가하고 상태 초기화
                                if let img = selectedImage {
                                    // 새 CanvasImage 객체를 만들어 중앙에 추가
                                    canvasImages.append(CanvasImage(image: img))
                                    selectedImage = nil
                                    isCanvasPhotoEmpty = false
                                }
                            }) {
                                PhotoSelector(image: $selectedImage, sourceType: pickerSource)
                            }
            }
            .disabled(!isCanvasPhotoEmpty)
            
            Button(action: {
                self.snapshotImage = renderImage()
                self.showShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
                    .imageScale(.large)

            }
            .sheet(isPresented: $showShareSheet, onDismiss: {
            }) {
                let image = renderImage()
                    ShareSheet(items: [image])
            }
        }
        .padding()
        .background(Color(UIColor.secondarySystemBackground))

    }
    
    private func renderImage() -> UIImage {
        guard let canvasSuperview = canvasView.superview?.superview else {
            return UIImage()
        }

        // subviews[0] = CanvasImageView, subviews[1] = PencilCanvasView
        let canvasLayerView = canvasSuperview.subviews[19]
        let pencilLayerView = canvasSuperview.subviews[20]
        let size = canvasSuperview.bounds.size

        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { ctx in
            UIColor.white.setFill()
            ctx.fill(CGRect(origin: .zero, size: size))

            canvasLayerView.drawHierarchy(in: canvasLayerView.bounds, afterScreenUpdates: true)
            pencilLayerView.drawHierarchy(in: pencilLayerView.bounds, afterScreenUpdates: true)
        }
    }
    

}
