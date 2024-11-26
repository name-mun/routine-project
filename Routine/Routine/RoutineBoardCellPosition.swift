//
//  RoutineBoardCellShape.swift
//  Routine
//
//  Created by t2023-m0072 on 11/13/24.
//

import UIKit

/*
 1. 첫 보드 -> 1,3 or none (하나의 보드만 존재할 경우 none => count와 index를 통해 연산 가능)
 
 2. 코너 보드 -> 각각 판별
 1.홀수 줄 (line % 2 == 1) && row == 0 : MinXMaxY
 && row == 2 : MaxXMinY
 2.짝수 줄 (line % 2 == 0) && row == 0 : MinXMinY
 && row == 2 : MaxXMaxY
 
 3. 마지막 보드 -> dataCount == index + 1
 1.라인의 첫 보드 (line % 2 == 1 && row == 0) || (line % 2 == 0 && row == 2) : []
 2.두번째, 세번째 보드 -> row != 0
 1. 홀수 줄 (line % 2 == 1) : MaxXMinY
 2. 짝수 줄 (line % 2 == 0) : MinXMinY
 */

//MARK: - RoutineBoardCollectionViewCell.Position

extension RoutineBoardCollectionViewCell {
  
  //셀 보드의 위치
  struct Position {
    
    let role: Role
    let line: Line
    let row: Row
    
    init(dataCount: Int, index: Int) {
      self.role = Role(dataCount: dataCount, index: index)
      self.line = Line(index)
      self.row = Row(index)
    }
    
    //마스크 코너 반환
    func maskedCorner() -> CACornerMask {
      
      switch role {
      case .first:
        return [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        
      case .normal:
        switch (line, row) {
        case (.odd, .first): return [.layerMinXMaxYCorner]
        case (.odd, .third): return [.layerMaxXMinYCorner]
        case (.even, .first): return [.layerMaxXMaxYCorner]
        case (.even, .third): return [.layerMinXMinYCorner]
        default: return []
        }
        
      case .last:
        if row == .first { return [] }
        else if line == .odd { return [.layerMaxXMinYCorner] }
        else { return [.layerMinXMinYCorner] }
      }
    }
    
    
    //첫번째, 마지막, 그외
    enum Role {
      case first
      case normal
      case last
      
      init(dataCount: Int, index: Int) {
        if index == 0 && dataCount > 1 {
          self = .first
        } else if index == dataCount-1 {
          self = .last
        } else {
          self = .normal
        }
      }
    }
    
    //홀수 짝수 줄
    enum Line {
      case odd
      case even
      
      init(_ index: Int) {
        let line = index/3
        self = (line % 2 == 0) ? .odd : .even
      }
    }
    
    //라인의 첫번째, 두번째, 세번째
    enum Row {
      case first
      case second
      case third
      
      init(_ index: Int) {
        let index = index % 3
        switch index {
        case 0: self = .first
        case 1: self = .second
        default: self = .third
        }
      }
    }
  }
  
}


#Preview("MainRoutineViewController") {
  let viewController = MainRoutineViewController()
  return viewController
}
