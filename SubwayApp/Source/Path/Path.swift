//
//  Path.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/30.
//

import Foundation

struct Path: Codable {
    let departureStation: String
    let departureTime: String
    let arrivalStation: String
    let arrivalTime: String
    let path: [String]
}
