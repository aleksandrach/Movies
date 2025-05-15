//
//  AppEnvironment.swift
//  Movies
//
//  Created by Aleksandra Axeltra on 13.5.25.
//

import Foundation

enum AppEnvironment {
    static var current: Environment {
#if DEV
        return .dev
#elseif PROD
        return .prod
#else
        return .unknown
#endif
    }
    
    enum Environment {
        case dev, prod, unknown
        
        var baseURL: String {
            switch self {
            case .dev:
                return "https://api.themoviedb.org/3/"
            case .prod:
                return "https://api.themoviedb.org/3/"
            case .unknown:
                return "https://api.themoviedb.org/3/"
            }
        }
    }
}
