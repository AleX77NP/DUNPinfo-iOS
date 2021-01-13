//
//  UserInfo.swift
//  DUNP-info
//
//  Created by Aleksandar on 13/11/2020.
//

import Foundation
import Firebase

func getAllTypes() -> [String] { // svi tipovi vesti //
    return ["vesti", "obavestenja", "obavestenja smera", "raspored ispita","raspored predavanja", "termini konsultacija", "instagram"]
}

func saveUserInfo(username: String, password: String) -> Void { // cuva email i lozinku //
    UserDefaults.standard.setValue(username, forKey: "username")
    UserDefaults.standard.setValue(password, forKey: "password")
}


func getMe() -> Any? { // vraca podatke o korisniku //
    let me = UserDefaults.standard.value(forKey: "username")
    return me != nil ? me : ""
}

func getFinished() -> Bool { // vraca true ako je korisnik zavrsio tutorial, inace false //
    let finished = UserDefaults.standard.value(forKey: "finishedT")
    return finished != nil ? true : false
}

func getMyToken() -> Any? { // vraca fcm token //
    let token = UserDefaults.standard.value(forKey: "fcmToken")
    return token != nil ? token : ""
}

func podesiPretplate(pretplate: [String]) -> Void { // menja pretplate korisnika //
    let mojePretplate = try! JSONEncoder().encode(pretplate)
    UserDefaults.standard.setValue(mojePretplate, forKey: "pretplate")

}

func vratiPretplate() -> [String] { // vraca sve izabrane pretplate //
    var pretplate: [String] = []
    let mojeP = UserDefaults.standard.data(forKey: "pretplate")
    if mojeP != nil {
        pretplate = try! JSONDecoder().decode([String].self, from: mojeP!)
    }
    
    return pretplate
}

// ovde se formiraju departmani i smerovi kako bi bili odgovarajuci za url za slanje novosti //

func formirajDepartmane() -> String {
    var departmani : String = ""
    let myDeps = getMyDepartments()
    for dep in myDeps {
        departmani.append(dep.name.uppercased())
        departmani.append("_")
    }
    let konacniDep = departmani.dropLast()
    return String(konacniDep)
}

func formirajSmerove() -> String {
    var smerovi : String = ""
    let myCourses = getMyCourses()
    for course in myCourses {
        smerovi.append(course)
        smerovi.append("_")
    }
    let konacniSmerovi = smerovi.dropLast()
    return String(konacniSmerovi)
}

func formirajPretplate() -> String {
    var pretplate: String = ""
    let mojePret = vratiPretplate()
    for pret in mojePret {
        pretplate.append(pret)
        pretplate.append(" ")
    }
    let konacne = pretplate.dropLast()
    return String(konacne)
}

func setMyToken() {
    Messaging.messaging().token { token, error in
      if let error = error {
        print("Error fetching FCM registration token: \(error)")
      } else if let token = token {
        //print("FCM registration token: \(token)")
        UserDefaults.standard.setValue(token, forKey: "fcmToken")
      }
    }
}

// cuva korisnika i sve njegove pretplate na serveru //

func onFinishTutorial() -> Void {
    
    let email: String = UserDefaults.standard.value(forKey: "username") != nil ? UserDefaults.standard.value(forKey: "username") as! String  : "username"
    let lozinka = UserDefaults.standard.value(forKey: "password") != nil ? UserDefaults.standard.value(forKey: "password") as! String  : "password"
    let departmani = formirajDepartmane()
    let smerovi = formirajSmerove()
    let fcm_token = UserDefaults.standard.value(forKey: "fcmToken") != nil ? UserDefaults.standard.value(forKey: "fcmToken") as! String  : "fcm_token"
    let pretplate = formirajPretplate()
    
    let student  = Student(email: email, lozinka: lozinka, fcm_token: fcm_token, pretplate: pretplate, departmani: departmani, smerovi:smerovi)
    guard let jsonData = try? JSONEncoder().encode(student) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
    
    let Url = String(format: "http://185.143.45.132/api/novosti/prijava_studenta/")
        guard let serviceUrl = URL(string: Url) else { return }
    var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type") 
           request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling POST")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                print(response)
                print(data)
            }.resume()
}

// formira URL na osnovu svih pretplata //

func formirajURL(id: Int) -> String {
    let departmani: departmentsChanged = .sharedDeps
    let smerovi: coursesChanged = .sharedCourses
    let pretplate: subsChanged = .subsC
    
    var url: String = "http://185.143.45.132/api/novosti/?latest_id=" + String(id)
    
    for p in pretplate.subs {
        if p == "obavestenja" || p == "vesti" || p == "instagram" {
            url.append("&tip=" + p)
        }
        else if p == "obavestenja smera" || p == "raspored ispita" || p == "raspored predavanja" {
            for smer in smerovi.courses {
                url.append("&tip=" + p.replacingOccurrences(of: " ", with: "_") + "-" + smer.replacingOccurrences(of: " ", with: "_"))
            }
        }
        else {
            for dep in departmani.deps {
                url.append("&tip=" + p.replacingOccurrences(of: " ", with: "_") + "-" + dep.name.replacingOccurrences(of: " ", with: "_").split(separator: "-")[0].uppercased())
            }
        }
    }
    print(url)
    return url
}



func changeStudentInfo() -> Void {
    let email: String = UserDefaults.standard.value(forKey: "username") != nil ? UserDefaults.standard.value(forKey: "username") as! String  : "username"
    let lozinka = UserDefaults.standard.value(forKey: "password") != nil ? UserDefaults.standard.value(forKey: "password") as! String  : "password"
    let departmani = formirajDepartmane()
    let smerovi = formirajSmerove()
    let fcm_token = UserDefaults.standard.value(forKey: "fcmToken") != nil ? UserDefaults.standard.value(forKey: "fcmToken") as! String  : "fcm_token"
    let pretplate = formirajPretplate()
    
    let student  = Student(email: email, lozinka: lozinka, fcm_token: fcm_token, pretplate: pretplate, departmani: departmani, smerovi:smerovi)
    guard let jsonData = try? JSONEncoder().encode(student) else {
                print("Error: Trying to convert model to JSON data")
                return
            }
    let Url = String(format: "http://185.143.45.132/api/novosti/izmena_pretplata/")
        guard let serviceUrl = URL(string: Url) else { return }
    
    var request = URLRequest(url: serviceUrl)
        request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
           request.setValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = jsonData
    
    URLSession.shared.dataTask(with: request) { data, response, error in
                guard error == nil else {
                    print("Error: error calling POST")
                    print(error!)
                    return
                }
                guard let data = data else {
                    print("Error: Did not receive data")
                    return
                }
                guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
                    print("Error: HTTP request failed")
                    return
                }
                print(response)
                print(data)
            }.resume()
}



class subsChanged: ObservableObject { // visak? //
    private init() {}
    static let subsC = subsChanged()
    @Published var subs = vratiPretplate()
}


