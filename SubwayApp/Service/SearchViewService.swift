//
//  APIService.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/06/05.
//

import Foundation
import Alamofire

struct SearchViewService {
    static let shared = SearchViewService()
    
    private init (){}
    
    struct Constants {
        static let baseURL = "http://15.165.244.220/"
        static let header: HTTPHeaders = ["Content-Type": "application/json"]
    }
    enum NetworkResult<T> {
        case success(T)
        case requestErr(T)
        case pathErr
        case serverErr
        case networkFail
    }
    private func getEncodedUrl(with string: String) -> URL? {
        let encodedString = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        return URL(string: encodedString)
    }
    func getSubway(line: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        guard let url = getEncodedUrl(with: Constants.baseURL + "/station/" + line) else {
            completion(.pathErr)
            return
        }
        let request = AF.request(url, method: .get, encoding: JSONEncoding.default, headers: Constants.header)
        request.responseData { response in
            switch response.result {
            case .success:
                guard let status = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let result = self.judgeStatus(by: status, value)
                completion(result)
            case .failure:
                completion(.networkFail)
            }
        }
    }
        
    private func judgeStatus(by statusCode: Int, _ data: Data) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        guard let decodeData = try? decoder.decode(Subway.self, from: data) else { return .pathErr }
        switch statusCode {
        case 200: return .success(decodeData.stationInfo)
        case 400: return .pathErr
        case 500: return .serverErr
        default: return .networkFail
        }
    }
}
