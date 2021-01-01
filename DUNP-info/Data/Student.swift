//
//  Student.swift
//  DUNP-info
//
//  Created by Aleksandar on 14/11/2020.
//

import Foundation

class Student: Codable {
    
    var email: String?
    var lozinka: String
    var fcm_token: String
    var pretplate: String
    var departmani: String
    var smerovi: String
    
    init(email: String, lozinka:String,fcm_token: String, pretplate:String, departmani:String, smerovi: String) {
        self.email = email
        self.lozinka = lozinka
        self.fcm_token = fcm_token
        self.pretplate = pretplate
        self.departmani = departmani
        self.smerovi = smerovi
    }
}
