//
//  APICallser.swift
//  SubwayApp
//
//  Created by 김영균 on 2022/05/22.
//

import Foundation
import Alamofire

final class APICaller {
    static let shared = APICaller();
    private init() {}
    
    struct Constants {
        static let baseURL = "15.165.244.220"
    }
    enum HTTPMethod1: String {
        case GET
        case POST
    }
    enum APIError: Error {
        case failedToGetData
    }

    public func getSubway(completion: @escaping (Result<Subway, Error>) -> Void) {
        let urlString = "http://15.165.244.220/station/1호선"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        var request = URLRequest(url: url)
        request.method = .get
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                print("error1")
                completion(.failure(APIError.failedToGetData))
                return
            }
            do {
                print("success")
                let ob = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(ob)
            } catch {
                print("error")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    public func getSub() {
        let urlString = "http://15.165.244.220/station/1호선"
        let encodedString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let url = URL(string: encodedString)!
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Subway.self) { response in
                switch response.result {
                case .success(let model):
                    print(model.stationInfo[0])
                case.failure(let error):
                    print(error)
                }
            }
    }
}
