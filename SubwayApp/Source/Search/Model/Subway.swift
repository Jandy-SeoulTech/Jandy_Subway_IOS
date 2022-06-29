//
//  Subway.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import Foundation

struct Subway: Codable {
    let stationInfo:[Information]
}
struct Information: Codable {
    let 전철역명: String
    let 호선: String
}
