//
//  SubwayLine.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import Foundation

struct SubwayLine {
    var line: [String] = ["1", "2", "3", "4", "5", "6", "7", "8", "9",
                          "수인분당", "공항철도", "경의중앙", "경춘", "신분당", "우이신설"]
    var name: [String] = ["1호선", "2호선", "3호선", "4호선", "5호선", "6호선", "7호선", "8호선", "9호선",
                          "수인분당선", "공항철도", "경의중앙선", "경춘선", "신분당선", "우이신설선"]
    var color: [Int] = [0x0052A4, 0x009D3E, 0xEF7C1C, 0x00A5DE, 0x996CAC, 0xCD7C2F,
                        0x747F00, 0xEA545D, 0xBB8336, 0xF5A200, 0x0090D2, 0x77C4A3,
                        0x0C8E72, 0xD4003B ,0xB0CE18]
}
