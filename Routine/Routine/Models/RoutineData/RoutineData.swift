//
//  RoutineData.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import Foundation

struct RoutineData: JSONCodable, CustomStringConvertible {
    
    ///테스트용 Mock
    static let mock = RoutineData(title: "제목",
                                  color: .white,
                                  sticker: "applelogo",
                                  startDate: MockData.date,
                                  repeatation: .default)
    
    //식별자 - RoutineID(타입별칭)
    let id: RoutineID
    
    //제목
    var title: String
    //보드 색
    var color: BoardColor
    //스티커 - AssetName(타입별칭)
    var sticker: AssetName
    
    //시작날짜(DataID)
    let startDate: Date
    //중단날짜(nil일 경우 중단 미설정)
    var stopDate: Date?
    //반복주기
    var repeatation: Repeatation
    //알람 (미구현) - Alarm(타입별칭)
    var alarm: Alarm?
    
    /// print, String(describing:) - 데이터 확인용
    ///
    var description: String {
        let stopDate = "\(String(describing: stopDate))"
        let alarm = "\(alarm ?? "미설정")"
        
        return """
        [Routine]
        id: \(self.id)
        title: \(self.title)
        color: \(self.color)
        sticker: \(self.sticker)
        startDate: \(self.startDate)
        stopDate: \(stopDate)
        repeatation: \(String(describing: self.repeatation))
        alarm: \(alarm)
        """
    }
    
    /// 루틴 에디터 뷰를 통해 생성 시 사용
    ///
    ///Date() 런타임
    init(id: RoutineID = UUID(),
         title: String,
         color: BoardColor,
         sticker: AssetName,
         startDate: Date = Date(),
         stopDate: Date? = nil,
         repeatation: Repeatation,
         alarm: Alarm? = nil) {
        self.id = id
        self.title = title
        self.color = color
        self.sticker = sticker
        self.startDate = startDate
        self.stopDate = stopDate
        self.repeatation = repeatation
        self.alarm = alarm
    }
    
}


//MARK: - RoutineData 검증 메서드

extension RoutineData: Equatable {
    
    /// 루틴ID와 날짜ID만을 비교 연산
    static func == (lhs: RoutineData, rhs: RoutineData) -> Bool {
        return lhs.id == rhs.id && lhs.startDate == rhs.startDate
    }
    
    ///입력 날짜에 적합한 루틴인지 확인
    func isScheduled(_ date: Date) -> Bool {
        guard repeatation.contains(date),
              isAfterStart(date),
              !isStop(date) else { return false }
        return true
    }
    
    // 생성 날짜를 통한 확인 메서드
    private func isAfterStart(_ date: Date) -> Bool {
        return date.yyyyMMdd() >= startDate.yyyyMMdd()
    }
    
    // 중단 날짜를 통한 확인 메서드
    private func isStop(_ date: Date) -> Bool {
        guard let stopDate = self.stopDate else { return false }
        return date >= stopDate
    }

}

private extension Date {
    
    func yyyyMMdd() -> String {
        let year = Calendar.current.component(.year, from: self)
        let month = Calendar.current.component(.month, from: self)
        let day = Calendar.current.component(.day, from: self)
        
        let monthString = month < 10 ? "0" + "\(month)" : "\(month)"
        let dayString = day < 10 ? "0" + "\(day)" : "\(day)"

        let yyyyMMdd = ["\(year)", monthString, dayString].joined()

        return yyyyMMdd
    }
}
