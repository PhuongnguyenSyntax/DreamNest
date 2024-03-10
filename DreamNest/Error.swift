//
//  Error.swift
//  DreamNest
//
//  Created by Flama Henkel on 01.03.24.
//

import Foundation


enum AppError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    case unableToComplete
}
