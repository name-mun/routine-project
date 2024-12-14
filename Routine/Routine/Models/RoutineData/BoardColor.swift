//
//  BoardColor.swift
//  Routine
//
//  Created by t2023-m0072 on 12/2/24.
//

import UIKit

///보드 컬러 열거형
///
///getColor() 메서드를 통해 UIColor를 반환
///
enum BoardColor: Codable, CaseIterable, Comparable {
    
    case white
    case yello
    case blue
    case green
    case red

    func get() -> UIColor {
        switch self {
        case .white: return UIColor.white.withAlphaComponent(0.3)
        case .yello: return UIColor.systemYellow.withAlphaComponent(0.3)
        case .blue: return UIColor.blue.withAlphaComponent(0.3)
        case .green: return UIColor.green.withAlphaComponent(0.3)
        case .red: return UIColor.red.withAlphaComponent(0.3)
        }
    }
}
