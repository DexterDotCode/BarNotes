//
//  Logger+Ext.swift
//  BarNotes
//
//  Created by Tanish Mittal on 20/07/25.
//

import Foundation
import OSLog

extension Logger {
	static let subsystem = "com.dextercode.BarNotes"
	
	static let ui = Logger(subsystem: subsystem, category: "UI")
	static let dataOperations = Logger(subsystem: subsystem, category: "DataOperations")
	static let storeKit = Logger(subsystem: subsystem, category: "StoreKit")
}
