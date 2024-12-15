//
//  JSONCodable.swift
//  Routine
//
//  Created by t2023-m0072 on 12/6/24.
//

import Foundation

/// JSON 형태의 인코딩 디코딩 지원
///
/// init?(from: Data): JSON 형태의 Data 값을 통해 생성
///
/// json(): JSON 형태의 Data 값을 반환
///
protocol JSONCodable: Codable {
    
}

extension JSONCodable {
    
    /// JSON 형태의 Data 를 반환
    ///
    func json() -> Data? {
        let data = try? JSONEncoder().encode(self)
        
        return data
    }
    
    /// JSON 형태의 Data 값을 통해 생성
    ///
    init?(from data: Data) {
        guard let data = try? JSONDecoder().decode(Self.self, from: data) else  {
            return nil
        }
        
        self = data
    }
}
