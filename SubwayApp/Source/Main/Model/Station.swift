//
//  Station.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/14.
//

import Foundation

struct Station: Codable {
    let routeInfo: [RouteInfo]
    let arriveInfo: [ArriveInfo]
}

struct RouteInfo: Codable {
    let updnLine: String
    let lstcarAt: String
    let statnNm: String
    let directAt: String
    let trainSttus: String
    let trainNo: String
    let congestion: String
    let statnTnm: String
}
struct ArriveInfo: Codable {
    let arriveTime: String
    let btrainSttus: String?
    let updnLine: String
    let trainNo: String
    let statNm: String
    let statnTnm: String
}
