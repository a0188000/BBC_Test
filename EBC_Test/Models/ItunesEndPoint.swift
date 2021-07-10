//
//  ItunesEndPoint.swift
//  EBC_Test
//
//  Created by 沈維庭 on 2021/7/10.
//

import Alamofire
import Foundation

enum ItunesEndPoint {
    case searchMusic(musiceName: String)
}

extension ItunesEndPoint: URLRequestConvertible {
    private var houseStirng: String { Config.hostString }
    
    private var method: HTTPMethod {
        switch self {
        case .searchMusic: return .get
        }
    }
    
    private var pathString: String {
        switch self {
        case .searchMusic: return "/search"
        }
    }
    
    private var parameters: Parameters {
        switch self {
        case .searchMusic(let muscicName):
            return ["term": "\(muscicName)"]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        return try URLEncoding.default.encode(URLRequest(url: "\(houseStirng)\(pathString)", method: method), with: parameters)
    }
}
