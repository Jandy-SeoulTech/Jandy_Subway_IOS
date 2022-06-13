//
//  LineInformation.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import Foundation

struct LineInformation {
    static let shared = LineInformation()
    
    private init (){}
    
    var name: [String] = ["1호선", "2호선", "3호선", "4호선", "5호선",
                          "6호선", "7호선", "8호선", "9호선","수인분당선",
                          "공항철도", "경의중앙선", "경춘선", "신분당선", "우이신설선"]
    var lineToColor: [String:Int] = ["1호선": 0x0052A4, "2호선": 0x009D3E, "3호선": 0xEF7C1C, "4호선": 0x00A5DE,
                                     "5호선": 0x996CAC, "6호선": 0xCD7C2F, "7호선": 0x747F00, "8호선": 0xEA545D,
                                     "9호선": 0xBB8336, "수인분당선": 0xF5A200, "공항철도": 0x0090D2, "경의중앙선": 0x77C4A3,
                                     "경춘선": 0x0C8E72, "신분당선": 0xD4003B, "우이신설선": 0xB0CE18]
    var lineToName: [String:String] = ["1호선": "one", "2호선": "two", "3호선": "three", "4호선": "four",
                                       "5호선": "five", "6호선": "six", "7호선": "seven", "8호선": "eight",
                                       "9호선": "nine", "수인분당선": "suin_bundang", "공항철도": "airport_railroad", "경의중앙선": "gyeongui_jungang",
                                       "경춘선": "gyeongchun", "신분당선": "shinbundang", "우이신설선": "ui_sinseol"]
    public func getColor(name: String) -> Int {
        guard let color = lineToColor[name] else { return 0 }
        return color
    }
    public func convertIcName(name: String) -> String {
        guard let icname = lineToName[name] else { return "" }
        return icname
    }
}
