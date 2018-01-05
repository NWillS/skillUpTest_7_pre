//
//  TaskDaoTests.swift
//  skillUpTest_7_preTests
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import XCTest
@testable import skillUpTest_7_pre

class TaskDaoTests: XCTestCase {
    var moc = MocRealmTask()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        moc = MocRealmTask()
        moc.mocRealmTask().deleteAll()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    //    Task追加
    func testAddTask(){
//        setup
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 0)
        
        let taskTitle = MocRealmTask.dummyTitle[0]
        
//        exercise
        TaskDao.addTask(title: taskTitle)
        
//        verify
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmTask().findFirst(key: 1 as AnyObject)?.taskTitle, MocRealmTask.dummyTitle[0])
    }
    
    //    Task更新
    func testUpdateTask(){
//        setup
        TaskDao.addTask(title: MocRealmTask.dummyTitle[0])
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmTask().findFirst(key: 1 as AnyObject)?.taskTitle, MocRealmTask.dummyTitle[0])
        
        let savedTask = moc.mocRealmTask().findFirst()
        
        let updateTask = TaskDto()
        updateTask.taskId = (savedTask?.taskId)!
        updateTask.taskTitle = MocRealmTask.dummyTitle[1]
        
//        exercise
        TaskDao.updateTask(task: updateTask)
        
//        verify
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmTask().findFirst(key: 1 as AnyObject)?.taskTitle, MocRealmTask.dummyTitle[1])
    }
    //    Task取得
    func testGetTask(){
//        setup
        TaskDao.addTask(title: MocRealmTask.dummyTitle[0])
        
//        exercise
        guard let gotTask = TaskDao.getTask(taskId: 1) else{
            return
        }
        
//        verify
        XCTAssertEqual(gotTask.taskTitle, MocRealmTask.dummyTitle[0])
    }
    //    Task削除
    func testDeleteTask(){
//        setup
        TaskDao.addTask(title: MocRealmTask.dummyTitle[0])
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 1)
        XCTAssertEqual(moc.mocRealmTask().findFirst(key: 1 as AnyObject)?.taskTitle, MocRealmTask.dummyTitle[0])
        
//        exercise
        TaskDao.deleteTask(taskId: 1)
        
//        verify
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 0)
    }
    //    Task全取得
    func testGetAllTasks(){
//        setup
        TaskDao.addTask(title: MocRealmTask.dummyTitle[0])
        TaskDao.addTask(title: MocRealmTask.dummyTitle[1])
        TaskDao.addTask(title: MocRealmTask.dummyTitle[2])
        
//        exercise
        let results = TaskDao.getAllTasks()
        
//        verify
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 3)
        XCTAssertEqual(results.count, 3)
        
    }
    //    Task全削除
    func testDeleteAllTasks(){
//        setup
        TaskDao.addTask(title: MocRealmTask.dummyTitle[0])
        TaskDao.addTask(title: MocRealmTask.dummyTitle[1])
        TaskDao.addTask(title: MocRealmTask.dummyTitle[2])
        
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 3)
        
//        exercise
        TaskDao.deleteAllTasks()
        
//        verify
        XCTAssertEqual(moc.mocRealmTask().findAll().count, 0)
    }
}
