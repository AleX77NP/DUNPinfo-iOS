//
//  Department_list.swift
//  DUNP-info
//
//  Created by Aleksandar on 11/11/2020.
//

import Foundation


func getAllDepartments() -> [Department] {
    let allDepartments: [Department] = [
        Department(id:1,name:"Departman za pravne nauke", courses: ["Pravo"]),
        Department(id:2,name: "Departman za ekonomske nauke", courses: ["Ekonomija", "Poslovna informatika"]),
        Department(id:3,name: "Departman za filološke nauke nauke", courses: ["Srpska književnost i jezik", "Engleski jezik i književnost"]),
        Department(id:4,name: "Departman za filozofske nauke", courses: ["Psihologija", "Vaspitač u predškolskim ustanovama"]),
        Department(id:5,name: "Departman za matematičke nauke", courses: ["Matematika", "Matematika i fizika", "Informatika i matematika", "Informatika i fizika"]),
        Department(id:6,name:"Departman za tehničke nauke", courses: ["Arhitektura","Građevinarstvo","Računarska tehnika","Softversko inženjerstvo", "Audio i video tehnologije"]),
        Department(id:7,name:"Departman za hemijsko-tehnološke nauke", courses: ["Hemija","Poljoprivredna proizvodnja"]),
        Department(id:8,name:"Departman za biomedicinske nauke", courses: ["Biologija","Rehabilitacija","Sport i fizičko vaspitanje"]),
        Department(id:9,name:"Departman za umetnost", courses: ["Likovna umetnost"]),
        Department(id:10,name:"Departman za biotehničke nauke", courses: ["Prehrambena tehnologija","Agronomija"]),
    ]
    return allDepartments
}

func saveDepartments(myDeps: [Department]) -> Void {
    let depsSave = try! JSONEncoder().encode(myDeps)
    UserDefaults.standard.setValue(depsSave, forKey: "departmani")
}

func getMyDepartments() -> [Department] {
    var myDeps: [Department] = []
    let myData = UserDefaults.standard.data(forKey: "departmani")
    if myData != nil {
    myDeps = try! JSONDecoder().decode([Department].self, from: myData!)
    }
    
    return myDeps
}

func saveCourses(myCourses: [String]) -> Void {
    let coursesSave = try! JSONEncoder().encode(myCourses)
    UserDefaults.standard.setValue(coursesSave, forKey: "smerovi")
}

func getMyCourses() -> [String] {
    var courses: [String] = []
    let myC = UserDefaults.standard.data(forKey: "smerovi")
    if myC != nil {
        courses = try! JSONDecoder().decode([String].self, from: myC!)
    }
    
    return courses
}

func removeDepCourses(dep: Department) -> Void {
    let mojiKursevi : coursesChanged = .sharedCourses
    for kurs in mojiKursevi.courses {
        if(dep.courses.contains(kurs)) {
            mojiKursevi.courses = mojiKursevi.courses.filter { $0 != kurs }
        }
    }
    saveCourses(myCourses: mojiKursevi.courses)
}



class departmentsChanged: ObservableObject {
    private init() {}
    static let sharedDeps = departmentsChanged()
    @Published var deps = getMyDepartments()
}

class coursesChanged: ObservableObject {
    private init() {}
    static let sharedCourses = coursesChanged()
    @Published var courses = getMyCourses()
}

