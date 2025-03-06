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
                    .confirmationDialog("이미지 소스 선택", isPresented: $showSourceDialog) {
                                Button("사진 촬영") {
                                    pickerSource = .camera
                                    showImagePicker = true
                                }
                                Button("사진 앨범") {
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
                                }
                            }) {
                                PhotoSelector(image: $selectedImage, sourceType: pickerSource)
                            }
            }
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
        return canvasView.drawing.image(from: canvasView.bounds, scale: UIScreen.main.scale)
    }
}
