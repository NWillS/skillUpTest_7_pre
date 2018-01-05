//
//  MocRealmTask.swift
//  skillUpTest_7_preTests
//
//  Created by S N on 2018/01/05.
//  Copyright © 2018年 Seidi Nakamura. All rights reserved.
//

import XCTest
@testable import skillUpTest_7_pre

final class MocRealmTask: XCTestCase {
    
    func mocRealmTask() -> RealmDaoHelper<TaskDto> {
        return RealmDaoHelper<TaskDto>.init()
    }
    
    // MARK: - テスト用テキスト
    
    static let dummyTitle = ["0", "1", "2", "3", "4"]
    
}
