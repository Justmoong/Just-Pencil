//
//  ShareSheet.swift
//  Just Pencil
//
//  Created by ymy on 2/27/25.
//

import SwiftUI

struct ShareSheet: UIViewControllerRepresentable {
    let items: [Any]  // 공유할 아이템 (이미지 등)
    
    func makeUIViewController(context: Context) -> UIActivityViewController {
        // UIActivityViewController 생성 (기본 공유 시트)
        UIActivityViewController(activityItems: items, applicationActivities: nil)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // 업데이트 불필요
    }
}
