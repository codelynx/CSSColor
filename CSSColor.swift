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

	// Reference: http://www.w3.org/TR/css3-color/

	private static let table: [String: String] = [
		"aliceblue": "#F0F8FF",
		"antiquewhite": "#FAEBD7",
		"aqua": "#00FFFF",
		"aquamarine": "#7FFFD4",
		"azure": "#F0FFFF",
		"beige": "#F5F5DC",
		"bisque": "#FFE4C4",
		"black": "#000000",
		"blanchedalmond": "#FFEBCD",
		"blue": "#0000FF",
		"blueviolet": "#8A2BE2",
		"brown": "#A52A2A",
		"burlywood": "#DEB887",
		"cadetblue": "#5F9EA0",
		"chartreuse": "#7FFF00",
		"chocolate": "#D2691E",
		"coral": "#FF7F50",
		"cornflowerblue": "#6495ED",
		"cornsilk": "#FFF8DC",
		"crimson": "#DC143C",
		"cyan": "#00FFFF",
		"darkblue": "#00008B",
		"darkcyan": "#008B8B",
		"darkgoldenrod": "#B8860B",
		"darkgray": "#A9A9A9",
		"darkgreen": "#006400",
		"darkgrey": "#A9A9A9",
		"darkkhaki": "#BDB76B",
		"darkmagenta": "#8B008B",
		"darkolivegreen": "#556B2F",
		"darkorange": "#FF8C00",
		"darkorchid": "#9932CC",
		"darkred": "#8B0000",
		"darksalmon": "#E9967A",
		"darkseagreen": "#8FBC8F",
		"darkslateblue": "#483D8B",
		"darkslategray": "#2F4F4F",
		"darkslategrey": "#2F4F4F",
		"darkturquoise": "#00CED1",
		"darkviolet": "#9400D3",
		"deeppink": "#FF1493",
		"deepskyblue": "#00BFFF",
		"dimgray": "#696969",
		"dimgrey": "#696969",
		"dodgerblue": "#1E90FF",
		"firebrick": "#B22222",
		"floralwhite": "#FFFAF0",
		"forestgreen": "#228B22",
		"fuchsia": "#FF00FF",
		"gainsboro": "#DCDCDC",
		"ghostwhite": "#F8F8FF",
		"gold": "#FFD700",
		"goldenrod": "#DAA520",
		"gray": "#808080",
		"green": "#008000",
		"greenyellow": "#ADFF2F",
		"grey": "#808080",
		"honeydew": "#F0FFF0",
		"hotpink": "#FF69B4",
		"indianred": "#CD5C5C",
		"indigo": "#4B0082",
		"ivory": "#FFFFF0",
		"khaki": "#F0E68C",
		"lavender": "#E6E6FA",
		"lavenderblush": "#FFF0F5",
		"lawngreen": "#7CFC00",
		"lemonchiffon": "#FFFACD",
		"lightblue": "#ADD8E6",
		"lightcoral": "#F08080",
		"lightcyan": "#E0FFFF",
		"lightgoldenrodyellow": "#FAFAD2",
		"lightgray": "#D3D3D3",
		"lightgreen": "#90EE90",
		"lightgrey": "#D3D3D3",
		"lightpink": "#FFB6C1",
		"lightsalmon": "#FFA07A",
		"lightseagreen": "#20B2AA",
		"lightskyblue": "#87CEFA",
		"lightslategray": "#778899",
		"lightslategrey": "#778899",
		"lightsteelblue": "#B0C4DE",
		"lightyellow": "#FFFFE0",
		"lime": "#00FF00",
		"limegreen": "#32CD32",
		"linen": "#FAF0E6",
		"magenta": "#FF00FF",
		"maroon": "#800000",
		"mediumaquamarine": "#66CDAA",
		"mediumblue": "#0000CD",
		"mediumorchid": "#BA55D3",
		"mediumpurple": "#9370DB",
		"mediumseagreen": "#3CB371",
		"mediumslateblue": "#7B68EE",
		"mediumspringgreen": "#00FA9A",
		"mediumturquoise": "#48D1CC",
		"mediumvioletred": "#C71585",
		"midnightblue": "#191970",
		"mintcream": "#F5FFFA",
		"mistyrose": "#FFE4E1",
		"moccasin": "#FFE4B5",
		"navajowhite": "#FFDEAD",
		"navy": "#000080",
		"oldlace": "#FDF5E6",
		"olive": "#808000",
		"olivedrab": "#6B8E23",
		"orange": "#FFA500",
		"orangered": "#FF4500",
		"orchid": "#DA70D6",
		"palegoldenrod": "#EEE8AA",
		"palegreen": "#98FB98",
		"paleturquoise": "#AFEEEE",
		"palevioletred": "#DB7093",
		"papayawhip": "#FFEFD5",
		"peachpuff": "#FFDAB9",
		"peru": "#CD853F",
		"pink": "#FFC0CB",
		"plum": "#DDA0DD",
		"powderblue": "#B0E0E6",
		"purple": "#800080",
		"red": "#FF0000",
		"rosybrown": "#BC8F8F",
		"royalblue": "#4169E1",
		"saddlebrown": "#8B4513",
		"salmon": "#FA8072",
		"sandybrown": "#F4A460",
		"seagreen": "#2E8B57",
		"seashell": "#FFF5EE",
		"sienna": "#A0522D",
		"silver": "#C0C0C0",
		"skyblue": "#87CEEB",
		"slateblue": "#6A5ACD",
		"slategray": "#708090",
		"slategrey": "#708090",
		"snow": "#FFFAFA",
		"springgreen": "#00FF7F",
		"steelblue": "#4682B4",
		"tan": "#D2B48C",
		"teal": "#008080",
		"thistle": "#D8BFD8",
		"tomato": "#FF6347",
		"turquoise": "#40E0D0",
		"violet": "#EE82EE",
		"wheat": "#F5DEB3",
		"white": "#FFFFFF",
		"whitesmoke": "#F5F5F5",
		"yellow": "#FFFF00",
		"yellowgreen": "#9ACD32"
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

	class var aliceblue: XColor { return CSSColor.colorNamed("aliceblue")! }
	class var antiquewhite: XColor { return CSSColor.colorNamed("antiquewhite")! }
	class var aqua: XColor { return CSSColor.colorNamed("aqua")! }
	class var aquamarine: XColor { return CSSColor.colorNamed("aquamarine")! }
	class var azure: XColor { return CSSColor.colorNamed("azure")! }
	class var beige: XColor { return CSSColor.colorNamed("beige")! }
	class var bisque: XColor { return CSSColor.colorNamed("bisque")! }
	class var black: XColor { return CSSColor.colorNamed("black")! }
	class var blanchedalmond: XColor { return CSSColor.colorNamed("blanchedalmond")! }
	class var blue: XColor { return CSSColor.colorNamed("blue")! }
	class var blueviolet: XColor { return CSSColor.colorNamed("blueviolet")! }
	class var brown: XColor { return CSSColor.colorNamed("brown")! }
	class var burlywood: XColor { return CSSColor.colorNamed("burlywood")! }
	class var cadetblue: XColor { return CSSColor.colorNamed("cadetblue")! }
	class var chartreuse: XColor { return CSSColor.colorNamed("chartreuse")! }
	class var chocolate: XColor { return CSSColor.colorNamed("chocolate")! }
	class var coral: XColor { return CSSColor.colorNamed("coral")! }
	class var cornflowerblue: XColor { return CSSColor.colorNamed("cornflowerblue")! }
	class var cornsilk: XColor { return CSSColor.colorNamed("cornsilk")! }
	class var crimson: XColor { return CSSColor.colorNamed("crimson")! }
	class var cyan: XColor { return CSSColor.colorNamed("cyan")! }
	class var darkblue: XColor { return CSSColor.colorNamed("darkblue")! }
	class var darkcyan: XColor { return CSSColor.colorNamed("darkcyan")! }
	class var darkgoldenrod: XColor { return CSSColor.colorNamed("darkgoldenrod")! }
	class var darkgray: XColor { return CSSColor.colorNamed("darkgray")! }
	class var darkgreen: XColor { return CSSColor.colorNamed("darkgreen")! }
	class var darkgrey: XColor { return CSSColor.colorNamed("darkgrey")! }
	class var darkkhaki: XColor { return CSSColor.colorNamed("darkkhaki")! }
	class var darkmagenta: XColor { return CSSColor.colorNamed("darkmagenta")! }
	class var darkolivegreen: XColor { return CSSColor.colorNamed("darkolivegreen")! }
	class var darkorange: XColor { return CSSColor.colorNamed("darkorange")! }
	class var darkorchid: XColor { return CSSColor.colorNamed("darkorchid")! }
	class var darkred: XColor { return CSSColor.colorNamed("darkred")! }
	class var darksalmon: XColor { return CSSColor.colorNamed("darksalmon")! }
	class var darkseagreen: XColor { return CSSColor.colorNamed("darkseagreen")! }
	class var darkslateblue: XColor { return CSSColor.colorNamed("darkslateblue")! }
	class var darkslategray: XColor { return CSSColor.colorNamed("darkslategray")! }
	class var darkslategrey: XColor { return CSSColor.colorNamed("darkslategrey")! }
	class var darkturquoise: XColor { return CSSColor.colorNamed("darkturquoise")! }
	class var darkviolet: XColor { return CSSColor.colorNamed("darkviolet")! }
	class var deeppink: XColor { return CSSColor.colorNamed("deeppink")! }
	class var deepskyblue: XColor { return CSSColor.colorNamed("deepskyblue")! }
	class var dimgray: XColor { return CSSColor.colorNamed("dimgray")! }
	class var dimgrey: XColor { return CSSColor.colorNamed("dimgrey")! }
	class var dodgerblue: XColor { return CSSColor.colorNamed("dodgerblue")! }
	class var firebrick: XColor { return CSSColor.colorNamed("firebrick")! }
	class var floralwhite: XColor { return CSSColor.colorNamed("floralwhite")! }
	class var forestgreen: XColor { return CSSColor.colorNamed("forestgreen")! }
	class var fuchsia: XColor { return CSSColor.colorNamed("fuchsia")! }
	class var gainsboro: XColor { return CSSColor.colorNamed("gainsboro")! }
	class var ghostwhite: XColor { return CSSColor.colorNamed("ghostwhite")! }
	class var gold: XColor { return CSSColor.colorNamed("gold")! }
	class var goldenrod: XColor { return CSSColor.colorNamed("goldenrod")! }
	class var gray: XColor { return CSSColor.colorNamed("gray")! }
	class var green: XColor { return CSSColor.colorNamed("green")! }
	class var greenyellow: XColor { return CSSColor.colorNamed("greenyellow")! }
	class var grey: XColor { return CSSColor.colorNamed("grey")! }
	class var honeydew: XColor { return CSSColor.colorNamed("honeydew")! }
	class var hotpink: XColor { return CSSColor.colorNamed("hotpink")! }
	class var indianred: XColor { return CSSColor.colorNamed("indianred")! }
	class var indigo: XColor { return CSSColor.colorNamed("indigo")! }
	class var ivory: XColor { return CSSColor.colorNamed("ivory")! }
	class var khaki: XColor { return CSSColor.colorNamed("khaki")! }
	class var lavender: XColor { return CSSColor.colorNamed("lavender")! }
	class var lavenderblush: XColor { return CSSColor.colorNamed("lavenderblush")! }
	class var lawngreen: XColor { return CSSColor.colorNamed("lawngreen")! }
	class var lemonchiffon: XColor { return CSSColor.colorNamed("lemonchiffon")! }
	class var lightblue: XColor { return CSSColor.colorNamed("lightblue")! }
	class var lightcoral: XColor { return CSSColor.colorNamed("lightcoral")! }
	class var lightcyan: XColor { return CSSColor.colorNamed("lightcyan")! }
	class var lightgoldenrodyellow: XColor { return CSSColor.colorNamed("lightgoldenrodyellow")! }
	class var lightgray: XColor { return CSSColor.colorNamed("lightgray")! }
	class var lightgreen: XColor { return CSSColor.colorNamed("lightgreen")! }
	class var lightgrey: XColor { return CSSColor.colorNamed("lightgrey")! }
	class var lightpink: XColor { return CSSColor.colorNamed("lightpink")! }
	class var lightsalmon: XColor { return CSSColor.colorNamed("lightsalmon")! }
	class var lightseagreen: XColor { return CSSColor.colorNamed("lightseagreen")! }
	class var lightskyblue: XColor { return CSSColor.colorNamed("lightskyblue")! }
	class var lightslategray: XColor { return CSSColor.colorNamed("lightslategray")! }
	class var lightslategrey: XColor { return CSSColor.colorNamed("lightslategrey")! }
	class var lightsteelblue: XColor { return CSSColor.colorNamed("lightsteelblue")! }
	class var lightyellow: XColor { return CSSColor.colorNamed("lightyellow")! }
	class var lime: XColor { return CSSColor.colorNamed("lime")! }
	class var limegreen: XColor { return CSSColor.colorNamed("limegreen")! }
	class var linen: XColor { return CSSColor.colorNamed("linen")! }
	class var magenta: XColor { return CSSColor.colorNamed("magenta")! }
	class var maroon: XColor { return CSSColor.colorNamed("maroon")! }
	class var mediumaquamarine: XColor { return CSSColor.colorNamed("mediumaquamarine")! }
	class var mediumblue: XColor { return CSSColor.colorNamed("mediumblue")! }
	class var mediumorchid: XColor { return CSSColor.colorNamed("mediumorchid")! }
	class var mediumpurple: XColor { return CSSColor.colorNamed("mediumpurple")! }
	class var mediumseagreen: XColor { return CSSColor.colorNamed("mediumseagreen")! }
	class var mediumslateblue: XColor { return CSSColor.colorNamed("mediumslateblue")! }
	class var mediumspringgreen: XColor { return CSSColor.colorNamed("mediumspringgreen")! }
	class var mediumturquoise: XColor { return CSSColor.colorNamed("mediumturquoise")! }
	class var mediumvioletred: XColor { return CSSColor.colorNamed("mediumvioletred")! }
	class var midnightblue: XColor { return CSSColor.colorNamed("midnightblue")! }
	class var mintcream: XColor { return CSSColor.colorNamed("mintcream")! }
	class var mistyrose: XColor { return CSSColor.colorNamed("mistyrose")! }
	class var moccasin: XColor { return CSSColor.colorNamed("moccasin")! }
	class var navajowhite: XColor { return CSSColor.colorNamed("navajowhite")! }
	class var navy: XColor { return CSSColor.colorNamed("navy")! }
	class var oldlace: XColor { return CSSColor.colorNamed("oldlace")! }
	class var olive: XColor { return CSSColor.colorNamed("olive")! }
	class var olivedrab: XColor { return CSSColor.colorNamed("olivedrab")! }
	class var orange: XColor { return CSSColor.colorNamed("orange")! }
	class var orangered: XColor { return CSSColor.colorNamed("orangered")! }
	class var orchid: XColor { return CSSColor.colorNamed("orchid")! }
	class var palegoldenrod: XColor { return CSSColor.colorNamed("palegoldenrod")! }
	class var palegreen: XColor { return CSSColor.colorNamed("palegreen")! }
	class var paleturquoise: XColor { return CSSColor.colorNamed("paleturquoise")! }
	class var palevioletred: XColor { return CSSColor.colorNamed("palevioletred")! }
	class var papayawhip: XColor { return CSSColor.colorNamed("papayawhip")! }
	class var peachpuff: XColor { return CSSColor.colorNamed("peachpuff")! }
	class var peru: XColor { return CSSColor.colorNamed("peru")! }
	class var pink: XColor { return CSSColor.colorNamed("pink")! }
	class var plum: XColor { return CSSColor.colorNamed("plum")! }
	class var powderblue: XColor { return CSSColor.colorNamed("powderblue")! }
	class var purple: XColor { return CSSColor.colorNamed("purple")! }
	class var red: XColor { return CSSColor.colorNamed("red")! }
	class var rosybrown: XColor { return CSSColor.colorNamed("rosybrown")! }
	class var royalblue: XColor { return CSSColor.colorNamed("royalblue")! }
	class var saddlebrown: XColor { return CSSColor.colorNamed("saddlebrown")! }
	class var salmon: XColor { return CSSColor.colorNamed("salmon")! }
	class var sandybrown: XColor { return CSSColor.colorNamed("sandybrown")! }
	class var seagreen: XColor { return CSSColor.colorNamed("seagreen")! }
	class var seashell: XColor { return CSSColor.colorNamed("seashell")! }
	class var sienna: XColor { return CSSColor.colorNamed("sienna")! }
	class var silver: XColor { return CSSColor.colorNamed("silver")! }
	class var skyblue: XColor { return CSSColor.colorNamed("skyblue")! }
	class var slateblue: XColor { return CSSColor.colorNamed("slateblue")! }
	class var slategray: XColor { return CSSColor.colorNamed("slategray")! }
	class var slategrey: XColor { return CSSColor.colorNamed("slategrey")! }
	class var snow: XColor { return CSSColor.colorNamed("snow")! }
	class var springgreen: XColor { return CSSColor.colorNamed("springgreen")! }
	class var steelblue: XColor { return CSSColor.colorNamed("steelblue")! }
	class var tan: XColor { return CSSColor.colorNamed("tan")! }
	class var teal: XColor { return CSSColor.colorNamed("teal")! }
	class var thistle: XColor { return CSSColor.colorNamed("thistle")! }
	class var tomato: XColor { return CSSColor.colorNamed("tomato")! }
	class var turquoise: XColor { return CSSColor.colorNamed("turquoise")! }
	class var violet: XColor { return CSSColor.colorNamed("violet")! }
	class var wheat: XColor { return CSSColor.colorNamed("wheat")! }
	class var white: XColor { return CSSColor.colorNamed("white")! }
	class var whitesmoke: XColor { return CSSColor.colorNamed("whitesmoke")! }
	class var yellow: XColor { return CSSColor.colorNamed("yellow")! }
	class var yellowgreen: XColor { return CSSColor.colorNamed("yellowgreen")! }

}
