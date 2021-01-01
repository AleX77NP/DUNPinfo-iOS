//
//  Department.swift
//  DUNP-info
//
//  Created by Aleksandar on 11/11/2020.
//

import Foundation

class Department: Identifiable, Equatable, Codable {
    static func == (first: Department, second: Department) -> Bool {
        if first.name == second.name {
            return true
        }
        else {
            return false
        }
    }
    
    var id:Int
    var name: String
    var courses: [String]
    
    init(id:Int,name: String, courses: [String]) {
        self.id = id;
        self.name = name;
        self.courses = courses
    }
}


