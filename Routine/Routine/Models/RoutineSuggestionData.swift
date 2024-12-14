//
//  RoutineSuggestionData.swift
//  Routine
//
//  Created by mun on 11/17/24.
//
//
// 섹션 제목
// 섹션 부제목
// 섹션별 아잍템(제목, 아이콘, 배경색)

import Foundation

struct SuggestionData {

    static let mock: [SuggestionData] = [
        SuggestionData(
            sectionTitle: "미라클 모닝",
            subTitle: "하루의 시작을 상쾌하게 시작하세요.",
            routineSuggestionData: [
                RoutineData(
                    title: "침구류 정리",
                    color: .white,
                    sticker: "heart",
                    repeatation: .default),
                RoutineData(
                    title: "물한컵 마시기",
                    color: .blue,
                    sticker: "heart",
                    repeatation: .default),
                RoutineData(
                    title: "모닝 커피 한잔",
                    color: .yello,
                    sticker: "heart",
                    repeatation: .default)
            ]),
        SuggestionData(
            sectionTitle: "깨끗한 집",
            subTitle: "깨끗한 집만큼 뿌듯한게 없어요.",
            routineSuggestionData: [
                RoutineData(
                    title: "먼지 제거",
                    color: .white,
                    sticker: "heart",
                    repeatation: .default),
                RoutineData(
                    title: "세탁 하기",
                    color: .blue,
                    sticker: "heart",
                    repeatation: .default),
                RoutineData(
                    title: "화분 물주기",
                    color: .green,
                    sticker: "heart",
                    repeatation: .default)
            ]),
        SuggestionData(
            sectionTitle: "성장하는 나",
            subTitle: "나를 채우는 시간",
            routineSuggestionData: [
                RoutineData(
                    title: "하루 10분 독서",
                    color: .green,
                    sticker: "heart",
                    repeatation: .default),
                RoutineData(
                    title: "다이어리 쓰기",
                    color: .yello,
                    sticker: "heart",
                    repeatation: .default),
                RoutineData(
                    title: "등교 하기",
                    color: .white,
                    sticker: "heart",
                    repeatation: .default)
            ])
    ]

    var sectionTitle: String
    var subTitle: String
    var routineSuggestionData: [RoutineData]
}


