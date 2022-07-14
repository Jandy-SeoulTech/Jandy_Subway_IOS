//
//  APITarget.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import Foundation
import Moya

enum APITarget {
    case stationList(line: String = "all")
    case stationInfomation(line: String, station: String)
}

extension APITarget: TargetType {
    var baseURL: URL {
        return URL(string: "http://15.165.244.220")!
    }
    
    var path: String {
        switch self {
        case .stationList(let line):
            return "/station/" + line
        case .stationInfomation(let line, let station):
            return "/subway/" + line + "/" + station
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .stationList,
            .stationInfomation:
            return .get
        }
    
    }
    
    var task: Task {
        switch self {
        case .stationList(let line):
            return .requestParameters(parameters: ["line" : line],
                                      encoding: URLEncoding.queryString)
        case .stationInfomation(let line, let station):
            return .requestParameters(parameters: ["line" : line,
                                                  "station" : station],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .stationList, .stationInfomation:
            return ["Content-Type": "application/json"]
        }
    }
    
    
}
