//
//  Subway.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/05/22.
//

import Foundation
struct Subway: Codable {
    let stationInfo:[Info]
    
}
struct Info: Codable {
    let 전철역명: String
    let 호선: String
}
