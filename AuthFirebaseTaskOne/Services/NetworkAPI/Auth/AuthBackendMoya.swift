//
//  AuthBackendMoya.swift
//  AuthFirebaseTaskOne
//
//  Created by Rotach Roman on 25.06.2022.
//

import Foundation
import Moya

public enum AuthBackendMoya {
//    static private let Id = ""
    
    case checkUser(phone: String, id: String)
}

extension AuthBackendMoya: TargetType {
    
    public var baseURL: URL {
        return URL(string: "http://94.127.67.113:8099")!
    }
    
    public var path: String {
        switch self {
        case .checkUser:
            return "/checkUser"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .checkUser:
            return Method.post
        }
    }
    
    public var task: Task {
        switch self {
        case .checkUser(let phone, let id):
            return .requestParameters(parameters: [
                "phone" : phone,
                "id" : id
            ], encoding: JSONEncoding.default)
        }
    }
    
    public var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
    
    public var validationType: ValidationType {
        return .successCodes
      }
}
