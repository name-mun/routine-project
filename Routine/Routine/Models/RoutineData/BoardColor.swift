//
//  BoardColor.swift
//  Routine
//
//  Created by t2023-m0072 on 12/2/24.
//

import UIKit

///보드 컬러 열거형
///
///uiColor() 메서드를 통해 UIColor를 반환
///
enum BoardColor: Codable, CaseIterable, Comparable {
    
    case white
    case yello
    case blue
    case green
    case red

    func uiColor() -> UIColor {
        switch self {
        case .white:
            return UIColor(red: cgFloat(200),
                           green: cgFloat(150),
                           blue: cgFloat(200),
                           alpha: 1)
            
        case .yello:
            return UIColor(red: cgFloat(150),
                           green: cgFloat(200),
                           blue: cgFloat(255),
                           alpha: 1)
            
        case .blue:
            return UIColor(red: cgFloat(130),
                           green: cgFloat(170),
                           blue: cgFloat(200),
                           alpha: 1)
            
        case .green:
            return UIColor(red: cgFloat(170),
                           green: cgFloat(200),
                           blue: cgFloat(255),
                           alpha: 1)
            
        case .red:
            return UIColor(red: cgFloat(160),
                           green: cgFloat(170),
                           blue: cgFloat(230),
                           alpha: 1)
        }
    }
    
    private func cgFloat(_ value: Int) -> CGFloat {
        guard value < 256 else { return 1 }
        return CGFloat(value) / 255
    }
    
}
