//
//  CanvasImage.swift
//  Just Pencil
//
//  Created by ymy on 3/6/25.
//

import Foundation
import UIKit
import SwiftUI

struct CanvasImage: Identifiable {
        let id = UUID()
        var image: UIImage?
        // 이미지의 변환 상태 (위치, 스케일, 회전 각도)
        var offset: CGSize = .zero
        var lastOffset: CGSize = .zero    // 드래그 이전 위치 저장
        var scale: CGFloat = 1.0
        var lastScale: CGFloat = 1.0      // 핀치 이전 스케일
        var rotation: Angle = .zero
        var lastRotation: Angle = .zero   // 회전 제스처 시작 전 각도
}
