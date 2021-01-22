//
//  ForthTutorial.swift
//  DUNP-info
//
//  Created by Aleksandar on 12/11/2020.
//

import Foundation
import SwiftUI

struct ForthTutorial: View {
    
    @ObservedObject var myDeps : departmentsChanged = .sharedDeps
    @ObservedObject var myCourses: coursesChanged = .sharedCourses
    @ObservedObject var fetcher: NewsUpdater = .sharedNews
    @ObservedObject var settings: finishedTutorial = .shared
    
    init() {
    }
    
    var body: some View {
        VStack {
            Text("Izaberite jedan ili više smerova")
                .font(Font.custom("Ubuntu", fixedSize: 24))
                .bold()
                .padding(self.settings.isOver ? .vertical : .bottom)
              //  .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
            
            List(myDeps.deps) { dep in
                VStack{
                Text(dep.name)
                    .font(Font.custom("Ubuntu", fixedSize: 20))
                    .bold()
                    .padding(.vertical)
                   // .shadow(color: Color(hex: 0x5400cb), radius: 0.5)
                    ScrollView{
                    ForEach(dep.courses, id: \.self) {course in
                        if self.myCourses.courses.contains(course) {
                            Button(action: {
                                if !self.myCourses.courses.contains(course) {
                                self.myCourses.courses.append(course)
                                    saveCourses(myCourses: self.myCourses.courses)
                                    if(self.settings.isOver) {
                                        fetchNewsOnChange(fetcher: self.fetcher)
                                        changeStudentInfo()
                                    }
                                }
                                else {
                                    self.myCourses.courses =  self.myCourses.courses.filter { $0 != course }
                                    saveCourses(myCourses: self.myCourses.courses)
                                    if(self.settings.isOver) {
                                        fetchNewsOnChange(fetcher: self.fetcher)
                                        changeStudentInfo()
                                    }
                                }
                            }) {
                                CourseItemSelected(item: course)
                         }
                        } else {
                            Button(action: {
                                if !self.myCourses.courses.contains(course) {
                                self.myCourses.courses.append(course)
                                saveCourses(myCourses: self.myCourses.courses)
                                if(self.settings.isOver) {
                                    fetchNewsOnChange(fetcher: self.fetcher)
                                    changeStudentInfo()
                                  }
                                }
                                else {
                                    self.myCourses.courses =  self.myCourses.courses.filter { $0 != course }
                                    saveCourses(myCourses: self.myCourses.courses)
                                    if(self.settings.isOver) {
                                        fetchNewsOnChange(fetcher: self.fetcher)
                                        changeStudentInfo()
                                    }
                                }
                            }) {
                                CourseItem(item: course)
                          }
                        }
                    }
                    }.padding(.bottom)
              }
           }.navigationTitle("").navigationBarTitleDisplayMode(.inline)
            .accentColor(.clear)
        }
    }
}
