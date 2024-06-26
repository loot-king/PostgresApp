//
//  MainWindow.swift
//  Postgres
//
//  Created by Chris on 22/06/16.
//  Copyright © 2016 postgresapp. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {
	
	@objc dynamic var mainWindowModel: MainWindowModel! {
		didSet {
			func propagate(_ mainWindowModel: MainWindowModel, toChildrenOf parent: NSViewController) {
				if var consumer = parent as? MainWindowModelConsumer {
					consumer.mainWindowModel = mainWindowModel
				}
				for child in parent.children {
					propagate(mainWindowModel, toChildrenOf: child)
				}
			}
			propagate(mainWindowModel, toChildrenOf: self.contentViewController!)
		}
	}
	
	
	override func windowDidLoad() {
		super.windowDidLoad()
		
		guard let window = self.window else { return }
		window.titleVisibility = .hidden
		window.styleMask = [window.styleMask, .fullSizeContentView]
		window.titlebarAppearsTransparent = true
		window.isMovableByWindowBackground = true
		
		let model = MainWindowModel()
		mainWindowModel = model
	}
	
	
	func windowWillClose(_ notification: Notification) {
		NSApp.terminate(nil)
	}
}
