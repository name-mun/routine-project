//
//  Untitled.swift
//  Routine
//
//  Created by t2023-m0072 on 11/30/24.
//

import Foundation

/*
루틴 결과 매니저
 
 새로운 루틴결과를 생성, 수정, 삭제
 CRUD
 + createRoutineResults(날짜ID) -> default: RoutineResult(id: 루틴ID, isCompleted: false)
 + readRoutineResults(날짜ID) -> RountineResultByDate
 + updateRoutineResults(날짜ID, 루틴ID) toggle -> [RoutineResult]
 + deleteRountineResult(날짜ID, 루틴ID)

 */


///RoutineResult를 관리하는 싱글톤 객체
///
///CRUD 메서드 지원
///
class RoutineResultManager {
    
    static let shared = RoutineResultManager()
    
    private init() {}

    //
    func create(_ dateID: Date, _ routineID: RoutineID) {}
    
    //
    func read(_ dateID: Date, _ routineID: RoutineID) {}
    
    //
    func update(_ dateID: Date, _ routineID: RoutineID) {}
    
    //
    func delete(_ dateID: Date, _ routineID: RoutineID) {}
    
}

/*
 루틴 통계화면
 
 [RoutineResultByDate] 한달치
 -> [Routine: [date]] ->

 1. RoutineResultByRoutine와 RoutineResultByDate의 데이터 원본이 같기때문에 두 개의 데이터 형식이 불필요하다.👍
*/


//한 날짜를 기준으로 여러 루틴ID의 결과들
struct RoutineResultByDate {
    let calender: Date
    var routineResults: [RoutineResult] = []
    //delete
//    + createRoutineResults(날짜ID) -> default: RoutineResult(id: 루틴ID, isCompleted: false)
}


//루틴 결과
struct RoutineResult {
    let id: RoutineID = 0
    var isCompleted: Bool = false
}
