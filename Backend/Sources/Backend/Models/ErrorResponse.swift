//
//  ErrorResponse.swift
//  Backend
//
//  Created by Nathan Zhang on 7/5/25.
//


import Vapor

// A simple JSON payload for conveying errors
struct ErrorResponse: Content {
    let error: String
}
