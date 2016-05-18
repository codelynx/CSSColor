//
//	CSSColor.swift
//	CSSColor
//
//	Created by Kaz Yoshikawa on 5/18/16.
//
//	Copyright (c) 2016 Electricwoods LLC, Kaz Yoshikawa.
//	This software may be modified and distributed under the terms of the MIT license.
//

#if os (OSX)
import Cocoa
typealias XColor = NSColor
#elseif os(iOS)
import UIKit 
typealias XColor = UIColor
#endif


extension String {

	var hexadecimalColorComponents: [CGFloat]? {
		let table: [Character : UInt8] = [
			"0": 0x0, "1": 0x1, "2": 0x2, "3": 0x3, "4": 0x4, "5": 0x5, "6": 0x6, "7": 0x7, "8": 0x8, "9": 0x9,
			"a": 0xa, "b": 0xb, "c": 0xc, "d": 0xd, "e": 0xe, "f": 0xf,
			"A": 0xa, "B": 0xb, "C": 0xc, "D": 0xd, "E": 0xe, "F": 0xf
		]

		let characters = self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).characters
		if let character = characters.first where character != "#" {
			print("String.hexadecimalColorComponents: expected `#` character but `\(character)`.")
			return nil
		}

		switch characters.count {
		case 7, 9:  // #112233, #112233ff
			var byte: UInt8 = 0
			var components = [CGFloat]()
			for (index, character) in characters.enumerate() {
				if index == 0 {
					if character != "#" { return nil }
				}
				else if let value = table[character] {
					if index % 2 == 1 { byte = value }
					else { byte = byte * 0x10 + value; components.append(CGFloat(byte) / 255.0) }
				}
				else {
					print("String.hexadecimalColorComponents: expected hexadecimal character but `\(character)`.")
					return nil
				}
			}
			return components

		case 4, 5:	// #123, #123f
			var components = [CGFloat]()
			for (index, character) in characters.enumerate() {
				if index == 0 {
					if character != "#" { return nil }
				}
				else if let value = table[character] {
					let byte: UInt8 = value * 0x10 + value
					components.append(CGFloat(byte) / 255.0)
				}
				else {
					print("String.hexadecimalColorComponents: unexpected character `\(character)`.")
					return nil
				}
			}
			return components

		default:
			print("String.hexadecimalColorComponents: expected number of characters is 4,5,7 or 9 but \(characters.count).")
			return nil
		}
	}

}

public extension XColor {

	public convenience init?(hexadecimalString: String) {
		if let components = hexadecimalString.hexadecimalColorComponents {
			switch components.count {
			case 3: self.init(red: components[0], green: components[1], blue: components[2], alpha: 1.0)
			case 4: self.init(red: components[0], green: components[1], blue: components[2], alpha: components[3])
			default: return nil
			}
		}
		else { return  nil }
	}

}


public class CSSColor {

	// Reference: https://note.cman.jp/color/base_color.cgi

	private static let table: [String: String] = [
		"white": "#FFFFFF",
		"ivory": "#FFFFF0",
		"lightyellow": "#FFFFE0",
		"yellow": "#FFFF00",
		"snow": "#FFFAFA",
		"floralwhite": "#FFFAF0",
		"lemonchiffon": "#FFFACD",
		"cornsilk": "#FFF8DC",
		"seashell": "#FFF5EE",
		"lavenderblush": "#FFF0F5",
		"papayawhip": "#FFEFD5",
		"blanchedalmond": "#FFEBCD",
		"mistyrose": "#FFE4E1",
		"bisque": "#FFE4C4",
		"moccasin": "#FFE4B5",
		"navajowhite": "#FFDEAD",
		"peachpuff": "#FFDAB9",
		"gold": "#FFD700",
		"pink": "#FFC0CB",
		"lightpink": "#FFB6C1",
		"orange": "#FFA500",
		"lightsalmon": "#FFA07A",
		"darkorange": "#FF8C00",
		"coral": "#FF7F50",
		"hotpink": "#FF69B4",
		"tomato": "#FF6347",
		"orangered": "#FF4500",
		"deeppink": "#FF1493",
		"fuchsia": "#FF00FF",
		"magenta": "#FF00FF",
		"red": "#FF0000",
		"oldlace": "#FDF5E6",
		"lightgoldenrodyellow": "#FAFAD2",
		"linen": "#FAF0E6",
		"antiquewhite" : "#FAEBD7",
		"salmon": "#FA8072",
		"ghostwhite": "#F8F8FF",
		"mintcream": "#F5FFFA",
		"whitesmoke": "#F5F5F5",
		"beige": "#F5F5DC",
		"wheat": "#F5DEB3",
		"sandybrown": "#F4A460",
		"azure": "#F0FFFF",
		"honeydew": "#F0FFF0",
		"aliceblue": "#F0F8FF",
		"khaki": "#F0E68C",
		"lightcoral": "#F08080",
		"palegoldenrod": "#EEE8AA",
		"violet": "#EE82EE",
		"darksalmon": "#E9967A",
		"lavender": "#E6E6FA",
		"lightcyan": "#E0FFFF",
		"burlywood": "#DEB887",
		"plum": "#DDA0DD",
		"gainsboro": "#DCDCDC",
		"crimson": "#DC143C",
		"palevioletred": "#DB7093",
		"goldenrod": "#DAA520",
		"orchid": "#DA70D6",
		"thistle": "#D8BFD8",
		"lightgray": "#D3D3D3",
		"lightgrey": "#D3D3D3",
		"tan": "#D2B48C",
		"chocolate": "#D2691E",
		"peru": "#CD853F",
		"indianred": "#CD5C5C",
		"mediumvioletred": "#C71585",
		"silver": "#C0C0C0",
		"darkkhaki": "#BDB76B",
		"rosybrown": "#BC8F8F",
		"mediumorchid": "#BA55D3",
		"darkgoldenrod": "#B8860B",
		"firebrick": "#B22222",
		"powderblue": "#B0E0E6",
		"lightsteelblue": "#B0C4DE",
		"paleturquoise": "#AFEEEE",
		"greenyellow": "#ADFF2F",
		"lightblue": "#ADD8E6",
		"darkgray": "#A9A9A9",
		"darkgrey": "#A9A9A9",
		"brown": "#A52A2A",
		"sienna": "#A0522D",
		"yellowgreen": "#9ACD32",
		"darkorchid": "#9932CC",
		"palegreen": "#98FB98",
		"darkviolet": "#9400D3",
		"mediumpurple": "#9370DB",
		"lightgreen": "#90EE90",
		"darkseagreen": "#8FBC8F",
		"saddlebrown": "#8B4513",
		"darkmagenta": "#8B008B",
		"darkred": "#8B0000",
		"blueviolet": "#8A2BE2",
		"lightskyblue": "#87CEFA",
		"skyblue": "#87CEEB",
		"gray": "#808080",
		"grey": "#808080",
		"olive": "#808000",
		"purple": "#800080",
		"maroon": "#800000",
		"aquamarine": "#7FFFD4",
		"chartreuse": "#7FFF00",
		"lawngreen": "#7CFC00",
		"mediumslateblue": "#7B68EE",
		"lightslategray": "#778899",
		"lightslategrey": "#778899",
		"slategray": "#708090",
		"slategrey": "#708090",
		"olivedrab": "#6B8E23",
		"slateblue": "#6A5ACD",
		"dimgray": "#696969",
		"dimgrey": "#696969",
		"mediumaquamarine": "#66CDAA",
		"cornflowerblue": "#6495ED",
		"cadetblue": "#5F9EA0",
		"darkolivegreen": "#556B2F",
		"indigo": "#4B0082",
		"mediumturquoise": "#48D1CC",
		"darkslateblue": "#483D8B",
		"steelblue": "#4682B4",
		"royalblue": "#4169E1",
		"turquoise": "#40E0D0",
		"mediumseagreen": "#3CB371",
		"limegreen": "#32CD32",
		"darkslategray": "#2F4F4F",
		"darkslategrey": "#2F4F4F",
		"seagreen": "#2E8B57",
		"forestgreen": "#228B22",
		"lightseagreen": "#20B2AA",
		"dodgerblue": "#1E90FF",
		"midnightblue": "#191970",
		"aqua": "#00FFFF",
		"cyan": "#00FFFF",
		"springgreen": "#00FF7F",
		"lime": "#00FF00",
		"mediumspringgreen": "#00FA9A",
		"darkturquoise": "#00CED1",
		"deepskyblue": "#00BFFF",
		"darkcyan": "#008B8B",
		"teal": "#008080",
		"green": "#008000",
		"darkgreen": "#006400",
		"blue": "#0000FF",
		"mediumblue": "#0000CD",
		"darkblue": "#00008B",
		"navy": "#000080",
		"black": "#000000"
	]

	class var colorNames: [String] {
		return self.table.keys.map { $0 }
	}

	class func colorNamed(name: String) -> XColor? {
		if let hexadecimalString = CSSColor.table[name] {
			return XColor(hexadecimalString: hexadecimalString)
		}
		return nil
	}

	class var white: XColor { return CSSColor.colorNamed("white")! }
	class var ivory: XColor { return CSSColor.colorNamed("ivory")! }
	class var lightyellow: XColor { return CSSColor.colorNamed("lightyellow")! }
	class var yellow: XColor { return CSSColor.colorNamed("yellow")! }
	class var snow: XColor { return CSSColor.colorNamed("snow")! }
	class var floralwhite: XColor { return CSSColor.colorNamed("floralwhite")! }
	class var lemonchiffon: XColor { return CSSColor.colorNamed("lemonchiffon")! }
	class var cornsilk: XColor { return CSSColor.colorNamed("cornsilk")! }
	class var seashell: XColor { return CSSColor.colorNamed("seashell")! }
	class var lavenderblush: XColor { return CSSColor.colorNamed("lavenderblush")! }
	class var papayawhip: XColor { return CSSColor.colorNamed("papayawhip")! }
	class var blanchedalmond: XColor { return CSSColor.colorNamed("blanchedalmond")! }
	class var mistyrose: XColor { return CSSColor.colorNamed("mistyrose")! }
	class var bisque: XColor { return CSSColor.colorNamed("bisque")! }
	class var moccasin: XColor { return CSSColor.colorNamed("moccasin")! }
	class var navajowhite: XColor { return CSSColor.colorNamed("navajowhite")! }
	class var peachpuff: XColor { return CSSColor.colorNamed("peachpuff")! }
	class var gold: XColor { return CSSColor.colorNamed("gold")! }
	class var pink: XColor { return CSSColor.colorNamed("pink")! }
	class var lightpink: XColor { return CSSColor.colorNamed("lightpink")! }
	class var orange: XColor { return CSSColor.colorNamed("orange")! }
	class var lightsalmon: XColor { return CSSColor.colorNamed("lightsalmon")! }
	class var darkorange: XColor { return CSSColor.colorNamed("darkorange")! }
	class var coral: XColor { return CSSColor.colorNamed("coral")! }
	class var hotpink: XColor { return CSSColor.colorNamed("hotpink")! }
	class var tomato: XColor { return CSSColor.colorNamed("tomato")! }
	class var orangered: XColor { return CSSColor.colorNamed("orangered")! }
	class var deeppink: XColor { return CSSColor.colorNamed("deeppink")! }
	class var fuchsia: XColor { return CSSColor.colorNamed("fuchsia")! }
	class var magenta: XColor { return CSSColor.colorNamed("magenta")! }
	class var red: XColor { return CSSColor.colorNamed("red")! }
	class var oldlace: XColor { return CSSColor.colorNamed("oldlace")! }
	class var lightgoldenrodyellow: XColor { return CSSColor.colorNamed("lightgoldenrodyellow")! }
	class var linen: XColor { return CSSColor.colorNamed("linen")! }
	class var antiquewhite: XColor { return CSSColor.colorNamed("antiquewhite")! }
	class var salmon: XColor { return CSSColor.colorNamed("salmon")! }
	class var ghostwhite: XColor { return CSSColor.colorNamed("ghostwhite")! }
	class var mintcream: XColor { return CSSColor.colorNamed("mintcream")! }
	class var whitesmoke: XColor { return CSSColor.colorNamed("whitesmoke")! }
	class var beige: XColor { return CSSColor.colorNamed("beige")! }
	class var wheat: XColor { return CSSColor.colorNamed("wheat")! }
	class var sandybrown: XColor { return CSSColor.colorNamed("sandybrown")! }
	class var azure: XColor { return CSSColor.colorNamed("azure")! }
	class var honeydew: XColor { return CSSColor.colorNamed("honeydew")! }
	class var aliceblue: XColor { return CSSColor.colorNamed("aliceblue")! }
	class var khaki: XColor { return CSSColor.colorNamed("khaki")! }
	class var lightcoral: XColor { return CSSColor.colorNamed("lightcoral")! }
	class var palegoldenrod: XColor { return CSSColor.colorNamed("palegoldenrod")! }
	class var violet: XColor { return CSSColor.colorNamed("violet")! }
	class var darksalmon: XColor { return CSSColor.colorNamed("darksalmon")! }
	class var lavender: XColor { return CSSColor.colorNamed("lavender")! }
	class var lightcyan: XColor { return CSSColor.colorNamed("lightcyan")! }
	class var burlywood: XColor { return CSSColor.colorNamed("burlywood")! }
	class var plum: XColor { return CSSColor.colorNamed("plum")! }
	class var gainsboro: XColor { return CSSColor.colorNamed("gainsboro")! }
	class var crimson: XColor { return CSSColor.colorNamed("crimson")! }
	class var palevioletred: XColor { return CSSColor.colorNamed("palevioletred")! }
	class var goldenrod: XColor { return CSSColor.colorNamed("goldenrod")! }
	class var orchid: XColor { return CSSColor.colorNamed("orchid")! }
	class var thistle: XColor { return CSSColor.colorNamed("thistle")! }
	class var lightgray: XColor { return CSSColor.colorNamed("lightgray")! }
	class var lightgrey: XColor { return CSSColor.colorNamed("lightgrey")! }
	class var tan: XColor { return CSSColor.colorNamed("tan")! }
	class var chocolate: XColor { return CSSColor.colorNamed("chocolate")! }
	class var peru: XColor { return CSSColor.colorNamed("peru")! }
	class var indianred: XColor { return CSSColor.colorNamed("indianred")! }
	class var mediumvioletred: XColor { return CSSColor.colorNamed("mediumvioletred")! }
	class var silver: XColor { return CSSColor.colorNamed("silver")! }
	class var darkkhaki: XColor { return CSSColor.colorNamed("darkkhaki")! }
	class var rosybrown: XColor { return CSSColor.colorNamed("rosybrown")! }
	class var mediumorchid: XColor { return CSSColor.colorNamed("mediumorchid")! }
	class var darkgoldenrod: XColor { return CSSColor.colorNamed("darkgoldenrod")! }
	class var firebrick: XColor { return CSSColor.colorNamed("firebrick")! }
	class var powderblue: XColor { return CSSColor.colorNamed("powderblue")! }
	class var lightsteelblue: XColor { return CSSColor.colorNamed("lightsteelblue")! }
	class var paleturquoise: XColor { return CSSColor.colorNamed("paleturquoise")! }
	class var greenyellow: XColor { return CSSColor.colorNamed("greenyellow")! }
	class var lightblue: XColor { return CSSColor.colorNamed("lightblue")! }
	class var darkgray: XColor { return CSSColor.colorNamed("darkgray")! }
	class var darkgrey: XColor { return CSSColor.colorNamed("darkgrey")! }
	class var brown: XColor { return CSSColor.colorNamed("brown")! }
	class var sienna: XColor { return CSSColor.colorNamed("sienna")! }
	class var yellowgreen: XColor { return CSSColor.colorNamed("yellowgreen")! }
	class var darkorchid: XColor { return CSSColor.colorNamed("darkorchid")! }
	class var palegreen: XColor { return CSSColor.colorNamed("palegreen")! }
	class var darkviolet: XColor { return CSSColor.colorNamed("darkviolet")! }
	class var mediumpurple: XColor { return CSSColor.colorNamed("mediumpurple")! }
	class var lightgreen: XColor { return CSSColor.colorNamed("lightgreen")! }
	class var darkseagreen: XColor { return CSSColor.colorNamed("darkseagreen")! }
	class var saddlebrown: XColor { return CSSColor.colorNamed("saddlebrown")! }
	class var darkmagenta: XColor { return CSSColor.colorNamed("darkmagenta")! }
	class var darkred: XColor { return CSSColor.colorNamed("darkred")! }
	class var blueviolet: XColor { return CSSColor.colorNamed("blueviolet")! }
	class var lightskyblue: XColor { return CSSColor.colorNamed("lightskyblue")! }
	class var skyblue: XColor { return CSSColor.colorNamed("skyblue")! }
	class var gray: XColor { return CSSColor.colorNamed("gray")! }
	class var grey: XColor { return CSSColor.colorNamed("grey")! }
	class var olive: XColor { return CSSColor.colorNamed("olive")! }
	class var purple: XColor { return CSSColor.colorNamed("purple")! }
	class var maroon: XColor { return CSSColor.colorNamed("maroon")! }
	class var aquamarine: XColor { return CSSColor.colorNamed("aquamarine")! }
	class var chartreuse: XColor { return CSSColor.colorNamed("chartreuse")! }
	class var lawngreen: XColor { return CSSColor.colorNamed("lawngreen")! }
	class var mediumslateblue: XColor { return CSSColor.colorNamed("mediumslateblue")! }
	class var lightslategray: XColor { return CSSColor.colorNamed("lightslategray")! }
	class var lightslategrey: XColor { return CSSColor.colorNamed("lightslategrey")! }
	class var slategray: XColor { return CSSColor.colorNamed("slategray")! }
	class var slategrey: XColor { return CSSColor.colorNamed("slategrey")! }
	class var olivedrab: XColor { return CSSColor.colorNamed("olivedrab")! }
	class var slateblue: XColor { return CSSColor.colorNamed("slateblue")! }
	class var dimgray: XColor { return CSSColor.colorNamed("dimgray")! }
	class var dimgrey: XColor { return CSSColor.colorNamed("dimgrey")! }
	class var mediumaquamarine: XColor { return CSSColor.colorNamed("mediumaquamarine")! }
	class var cornflowerblue: XColor { return CSSColor.colorNamed("cornflowerblue")! }
	class var cadetblue: XColor { return CSSColor.colorNamed("cadetblue")! }
	class var darkolivegreen: XColor { return CSSColor.colorNamed("darkolivegreen")! }
	class var indigo: XColor { return CSSColor.colorNamed("indigo")! }
	class var mediumturquoise: XColor { return CSSColor.colorNamed("mediumturquoise")! }
	class var darkslateblue: XColor { return CSSColor.colorNamed("darkslateblue")! }
	class var steelblue: XColor { return CSSColor.colorNamed("steelblue")! }
	class var royalblue: XColor { return CSSColor.colorNamed("royalblue")! }
	class var turquoise: XColor { return CSSColor.colorNamed("turquoise")! }
	class var mediumseagreen: XColor { return CSSColor.colorNamed("mediumseagreen")! }
	class var limegreen: XColor { return CSSColor.colorNamed("limegreen")! }
	class var darkslategray: XColor { return CSSColor.colorNamed("darkslategray")! }
	class var darkslategrey: XColor { return CSSColor.colorNamed("darkslategrey")! }
	class var seagreen: XColor { return CSSColor.colorNamed("seagreen")! }
	class var forestgreen: XColor { return CSSColor.colorNamed("forestgreen")! }
	class var lightseagreen: XColor { return CSSColor.colorNamed("lightseagreen")! }
	class var dodgerblue: XColor { return CSSColor.colorNamed("dodgerblue")! }
	class var midnightblue: XColor { return CSSColor.colorNamed("midnightblue")! }
	class var aqua: XColor { return CSSColor.colorNamed("aqua")! }
	class var cyan: XColor { return CSSColor.colorNamed("cyan")! }
	class var springgreen: XColor { return CSSColor.colorNamed("springgreen")! }
	class var lime: XColor { return CSSColor.colorNamed("lime")! }
	class var mediumspringgreen: XColor { return CSSColor.colorNamed("mediumspringgreen")! }
	class var darkturquoise: XColor { return CSSColor.colorNamed("darkturquoise")! }
	class var deepskyblue: XColor { return CSSColor.colorNamed("deepskyblue")! }
	class var darkcyan: XColor { return CSSColor.colorNamed("darkcyan")! }
	class var teal: XColor { return CSSColor.colorNamed("teal")! }
	class var green: XColor { return CSSColor.colorNamed("green")! }
	class var darkgreen: XColor { return CSSColor.colorNamed("darkgreen")! }
	class var blue: XColor { return CSSColor.colorNamed("blue")! }
	class var mediumblue: XColor { return CSSColor.colorNamed("mediumblue")! }
	class var darkblue: XColor { return CSSColor.colorNamed("darkblue")! }
	class var navy: XColor { return CSSColor.colorNamed("navy")! }
	class var black: XColor { return CSSColor.colorNamed("black")! }

	/*
	class func printSource() {
		for name in self.table.keys {
			print("\tclass var \(name): XColor { return CSSColor.colorNamed(\"\(name)\")! }")
		}
	}
	*/
}
