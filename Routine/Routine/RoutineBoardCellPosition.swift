//
//  RoutineBoardCellShape.swift
//  Routine
//
//  Created by t2023-m0072 on 11/13/24.
//

import UIKit

//MARK: - RoutineBoardCellShape
enum RoutineBoardCellPosition {

    case sole
    case first
    case normal
    case upCorner(_ side: Side)
    case downCorner(_ side: Side)
    
    var maskedCorners: CACornerMask {
        switch self {
        case .sole, .normal:
            return []
            
        case .first:
            return [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            
        case .upCorner(let side):
            switch side {
            case .left:
                return [.layerMinXMinYCorner]
            case .right:
                return [.layerMaxXMinYCorner]
            }
            
        case .downCorner(let side):
            switch side {
            case .left:
                return [.layerMinXMaxYCorner]
            case .right:
                return [.layerMaxXMaxYCorner]
            }
        }
    }
    
    /*
     1. 첫 보드 -> 1,3 or none (하나의 보드만 존재할 경우 none => count와 index를 통해 연산 가능)
     2. 코너 보드 -> 각각 판별
        1.홀수: row == 0 : MinXMaxY / row == 2 : MaxXMinY
        2.짝수: row == 0 : MinXMinY / row == 2 : MaxXMaxY
    마지막 보드에 대해서 어떻게 적용할지
    포지션과 로우를 통해
    */
    
    init(dataCount: Int, index: Int) {
        
        let row = index % 3
        let line = (index / 3 - 1) % 2 //짝수 홀수 판별
        let isLast: Bool = dataCount == (index + 1)
        if dataCount == 1 && index == 0 { self = .sole  }
        else if index == 0 {  self = .first }
        else if false {
            
        }
        
        self = .normal
    }
    
    enum Side {
        case left
        case right
    }
    
    private enum Line {
        case odd
        case even
    }
}

#Preview("MainRoutineViewController") {
    let viewController = MainRoutineViewController()
    return viewController
}
