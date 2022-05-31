//
//  TabBarViewController.swift
//  Anxiolytic
//
//  Created by Yulia Gapunovych on 08.05.2022.
//  
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {

    // MARK: Properties

    var presenter: TabBarPresentation?

    // MARK: Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TabBarViewController: TabBarView {
    // TODO: implement view output methods
}
