//
//  APIService.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/07/14.
//

import Foundation
import Moya

struct APIService {
    static let shared = APIService()
    var provider = MoyaProvider<APITarget>()
    private init() {}
    
    enum NetworkResult<T> {
        case success(T)
        case requestErr
        case pathErr
        case serverErr
        case networkFail
    }
    
    func getStationList(at line: String,
                       completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.stationList(line: line)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let value = response.data
                let networkResult = judgeStatus(by: statusCode, value, type: Subway.self)
                completion(networkResult)
            case .failure(let err):
                debugPrint(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    func getStationInformation(at line: String,
                               station: String,
                               completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.stationInfomation(line: line, station: station)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let value = response.data
                let networkResult = judgeStatus(by: statusCode, value, type: Station.self)
                completion(networkResult)
            case .failure(let err):
                debugPrint(err.localizedDescription)
                completion(.networkFail)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, type: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(type, from: data) else { return .pathErr }
        switch statusCode {
            case 200:
                return .success(decodeData)
            case 400..<500:
                return .requestErr
            case 500:
                return .serverErr
            default:
                return .networkFail
        }
    }
}
