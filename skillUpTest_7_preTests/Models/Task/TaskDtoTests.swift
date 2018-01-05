//
//  TaskDtoTests.swift
//  skillUpTest_7_preTests
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import XCTest
@testable import skillUpTest_7_pre

class TaskDtoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    func testTaskDto(){
//        MARK:TaskDtoに値セット
//        setup
        let taskId = 1
        let taskTitle = "title"
        let updateDate = Date()
        
//        excercise
        let task = TaskDto()
        task.taskId = taskId
        task.taskTitle = taskTitle
        task.updateDate = updateDate
        
//        verify
        XCTAssertEqual(task.taskId, 1)
        XCTAssertEqual(task.taskTitle, "title")
        XCTAssertEqual(task.updateDate, updateDate)
    }
    func testPrimaryKey() {
//        MARK: PrimaryKeyを設定
//        exercise
        let primaryKey = TaskDto.primaryKey()
        
        //         verify
        XCTAssertNotNil(primaryKey)
        XCTAssertEqual(primaryKey, "taskId")
    }
}
