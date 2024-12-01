//
//  RoutineSticker.swift
//  Routine
//
//  Created by t2023-m0072 on 10/31/24.
//

import Foundation

//MARK: - 루틴 스티커
//TODO: 지원할 스티커 간소화, 네이밍 (+리팩토링)

enum RoutineSticker {
  
  //섹션(스티커)의 형태
  case structure(Structure)
//  case selfImprovement(SelfImprovement)
//  case comunication(Comunication)
//  case companionAnimal(CompanionAnimal)
//  case food(Food)
//  case cleaning(Cleaning)
//  case health(Health)
  case beauty(Beauty)
//  case finance(Finance)
//  case hobby(Hobby)
//  case kid(Kid)
//  case music(Music)
//  case nature(Nature)
//  case shopping(Shopping)
//  case socialMedia(SocialMedia)
//  case sport(Sport)
//  case travel(Travel)
//  case weather(Weather)
  
  // 건물 - 4개
  enum Structure{
    case house
    case building
    case school
    case store
  }
//
//  // 자기계발 - 10개
//  enum SelfImprovement {
//    case portfolio
//    case coding
//    case idea
//  }
//  
//  // 커뮤니케이션 - 4개
//  enum Comunication {
//    case good
//    case heart
//    case baton
//    case chat
//  }
//  
//  // 반려동물 - 3개
//  enum CompanionAnimal {
//    case cat
//    case dog
//    case feed
//  }
//  
//  // 음식, 음료 - 10개
//  enum Food {
//    case babyFood
//    case tableware
//    case cook
//    case kitchenTool
//    case bread
//    case iceCream
//    case coffee
//    case tea
//    case water
//    case salad
//  }
//  
//  // 청소 - 9개
//  enum Cleaning {
//    case broom
//    case detergent
//    case dishWashing
//    case wastebasket
//    case mopping
//    case laundry
//    case towel
//    case toilet
//  }
//  
//  // 건강 - 7개
//  enum Health {
//    case clock
//    case sleep
//    case medication
//    case owl
//    case pillow
//    case weighingMachine
//    case stair
//  }
//  
//  // 미용 - 7개
  enum Beauty {
    case handWash
    case bath
    case lotion
    case maskPack
    case shampoo
    case hair
    case perfume
  }
//  
//  // 금융 - 3개
//  enum Finance {
//    case cash
//    case calculator
//    case coinBank
//  }
//  
//  // 취미 - 10개
//  enum Hobby {
//    case photo
//    case chess
//    case gameController
//    case meditation
//    case movie
//    case fortuneCookie
//    case book
//    case palette
//    case plant
//    case youtube
//  }
//  
//  // 아이 - 2개 (육아가 더 적합할 것 같다.)
//  enum Kid {
//    case infant
//    case babyCarriage
//  }
//  
//  // 음악 - 2개
//  enum Music {
//    case headphones
//    case musicalNote
//  }
//  
//  // 자연 - 2개
//  enum Nature {
//    case tree
//    case lakeAndMountain
//  }
//  
//  // 쇼핑 - 2개
//  enum Shopping {
//    case cart
//    case bag
//  }
//  
//  // 소셜미디어 - 5개
//  enum SocialMedia {
//    case faceBook
//    case instagram
//    case netflix
//    case thread
//    case twitter
//  }
//  
//  //스포츠, 피트니스 - 11개
//  enum Sport {
//    case running
//    case dumbBell
//    case warmUp
//    case hiking
//    case basketball
//    case soccer
//    case tennis
//    case baseball
//    case bycicle
//    case muscle
//    case swimming
//  }
//  
//  //여행 - 3개
//  enum Travel {
//    case plane
//    case bag
//    case beach
//  }
//  
//  //날씨 - 1개
//  enum Weather {
//    case cloud
//  }
}
