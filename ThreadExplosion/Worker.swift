//
//  Worker.swift
//  ThreadExplosion
//
//  Created by Vladimir Ozerov on 13/12/2019.
//  Copyright © 2019 Sberbank. All rights reserved.
//

import Foundation


let completionQueue = DispatchQueue(label: "CompetionQueue", qos: .default, attributes: .concurrent)


class Worker {
	class Item {
		let i: Int
		var port: Port?

		var operation: BlockOperation {
			return BlockOperation { [weak self] in
				self?.main()
			}
		}

		init(_ i: Int) {
			self.i = i
		}

		func main() {
			print("begin(\(i))")

			// Wait for all threads to start
			Thread.sleep(forTimeInterval: 0.5)

			port = NSMachPort()
			completionQueue.async {
				print("async(\(self.i))")
				self.port?.send(before: Date(), components: nil, from: nil, reserved: 0)
			}

			RunLoop.current.add(port!, forMode: .default)
			RunLoop.current.run(mode: .default, before: .distantFuture)
			RunLoop.current.remove(port!, forMode: .default)

			print("end(\(i))")
		}
	}

	let queue = OperationQueue()
	var workItems: [Item] = []

	init() {
		// Uncomment to fix
//		queue.maxConcurrentOperationCount = 30
	}

	func explode(_ count: Int) {
		for i in 0..<count {
			let item = Item(i)
			workItems.append(item)

			let operation = item.operation
			queue.addOperation(operation)
		}
	}
}
