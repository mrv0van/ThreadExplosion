//
//  ThreadExplosionTests.swift
//  ThreadExplosionTests
//
//  Created by Vladimir Ozerov on 13/12/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

import XCTest
@testable import ThreadExplosion

class WorkerTests: XCTestCase {

    func testExample() {
		let worker = Worker()
		worker.explode(64)

		Thread.sleep(forTimeInterval: 1000)
	}
}
