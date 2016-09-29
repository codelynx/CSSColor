//
//	ColorTableViewCell.swift
//	CSSColor
//
//	Created by Kaz Yoshikawa on 5/18/16.
//
//	This software may be modified and distributed under the terms
//	of the MIT license.  See the LICENSE file for details.
//

import UIKit


class ColorTableViewCell: UITableViewCell {

	var color: UIColor?
	var colorName: String?

	@IBOutlet weak var colorView: UIView!
	@IBOutlet weak var colorLabel: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	override func layoutSubviews() {
		super.layoutSubviews()

		self.colorView.backgroundColor = self.color
		self.colorLabel.text = self.colorName
	}

}
