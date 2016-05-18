//
//	ColorTableCellView.swift
//	CSSColor
//
//	Created by Kaz Yoshikawa on 5/18/16.
//
//

import Cocoa



class ColorTableCellView: NSTableCellView {

	var color: NSColor?

	override func drawRect(dirtyRect: NSRect) {
		super.drawRect(dirtyRect)
	}

	override func layout() {
		super.layout()

		self.wantsLayer = true
		if let color = self.color {
			self.layer?.backgroundColor = color.CGColor
		}
	}
	
}
