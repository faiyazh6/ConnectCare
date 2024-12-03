//
//  Task.swift
//  ConnectCare
//
//  Created by Lincoln Takudzwa Nyarambi on 12/3/24.
//

import Foundation

struct Task: Identifiable, Codable {
    let id = UUID()
    var title: String
    var isCompleted: Bool
    var dueDate: Date
}
