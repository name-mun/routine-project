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
enum BoardColor: Codable {
    
    case white
    case yello
    case blue
    case green
    case red

    func getColor() -> UIColor {
        switch self {
        case .white: return UIColor.white
        case .yello: return UIColor.black
        case .blue: return UIColor.blue
        case .green: return UIColor.green
        case .red: return UIColor.red
        }
    }
}
