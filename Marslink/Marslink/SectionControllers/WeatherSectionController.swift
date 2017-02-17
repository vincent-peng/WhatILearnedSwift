//
//  WeatherSectionController.swift
//  Marslink
//
//  Created by Vincent Peng on 17/2/17.
//  Copyright © 2017 Ray Wenderlich. All rights reserved.
//

import UIKit
import IGListKit

class WeatherSectionController: IGListSectionController {
	
	var weather: Weather!
	var expanded = false
	
	override init() {
		super.init()
		inset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
	}

}

extension WeatherSectionController: IGListSectionType {
	
	func numberOfItems() -> Int {
		return expanded ? 5 : 1
	}
	
	func didUpdate(to object: Any) {
		weather = object as? Weather
	}
	
	func sizeForItem(at index: Int) -> CGSize {
		guard let context = collectionContext else { return .zero }
		let width = context.containerSize.width
		return CGSize(width: width, height: index == 0 ? 70 : 40)
	}
	
	func cellForItem(at index: Int) -> UICollectionViewCell {
		let cellClass: AnyClass = index == 0 ? WeatherSummaryCell.self : WeatherDetailCell.self
		let cell = collectionContext!.dequeueReusableCell(of: cellClass, for: self, at: index)
		if let cell = cell as? WeatherSummaryCell {
			cell.setExpanded(expanded)
		} else if let cell = cell as? WeatherDetailCell {
			let title: String, detail: String
			switch index {
			case 1:
				title = "SUNRISE"
				detail = weather.sunrise
			case 2:
				title = "SUNSET"
				detail = weather.sunset
			case 3:
				title = "HIGH"
				detail = "\(weather.high) C"
			case 4:
				title = "LOW"
				detail = "\(weather.low) C"
			default:
				title = "n/a"
				detail = "n/a"
			}
			cell.titleLabel.text = title
			cell.detailLabel.text = detail
		}
		return cell
	}
	
	func didSelectItem(at index: Int) {
		expanded = !expanded
		collectionContext?.reload(self)
	}
}
