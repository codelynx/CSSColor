//
//  ViewController.swift
//  CSSColor_OSX
//
//  Created by Kaz Yoshikawa on 5/18/16.
//
//

import Cocoa


class ColorTableViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

	var colorNames = CSSColor.colorNames

	override func viewDidLoad() {
		super.viewDidLoad()

		// Do any additional setup after loading the view.
	}

	override var representedObject: AnyObject? {
		didSet {
		// Update the view, if already loaded.
		}
	}
	
	func numberOfRowsInTableView(tableView: NSTableView) -> Int {
		return colorNames.count
	}
	
	func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
		guard let column = tableColumn?.identifier else { return nil }
		let colorName = colorNames[row]
		switch column {
		case "color":
			let cellView = tableView.makeViewWithIdentifier("color", owner: nil) as! ColorTableCellView
			cellView.color = CSSColor.colorNamed(colorName)!
			return cellView
		case "name":
			let cellView = tableView.makeViewWithIdentifier("name", owner: nil) as! NSTableCellView
			cellView.textField!.stringValue = colorName
			return cellView
		default:
			return nil
		}
	}

}

