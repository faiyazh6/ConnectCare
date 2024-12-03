//
//  Utils.swift
//  ConnectCare
//
//  Created by Lincoln Takudzwa Nyarambi on 12/3/24.
//

import Foundation

// Shared Date Formatter
let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

