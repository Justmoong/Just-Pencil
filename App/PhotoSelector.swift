//
//  PhotoSelector.swift
//  Just Pencil
//
//  Created by ymy on 3/6/25.
//

import Foundation
import UIKit
import SwiftUI

/// UIImagePickerController를 SwiftUI에서 쓰기 위한 래퍼
struct PhotoSelector: UIViewControllerRepresentable {
    // 선택된 이미지를 바인딩으로 전달
    @Binding var image: UIImage?
    // 카메라 또는 앨범 소스 타입
    var sourceType: UIImagePickerController.SourceType

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator  // 델리게이트 연결
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    // 코디네이터를 통해 UIImagePickerControllerDelegate 구현
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: PhotoSelector
        init(_ parent: PhotoSelector) { self.parent = parent }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage  // 선택된 UIImage를 바인딩에 설정
            }
            picker.dismiss(animated: true)
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}
