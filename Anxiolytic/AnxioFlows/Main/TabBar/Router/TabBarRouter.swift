//
//  TabBarRouter.swift
//  Anxiolytic
//
//  Created by Yulia Gapunovych on 08.05.2022.
//  
//

import Foundation
import UIKit

class TabBarRouter {

    // MARK: Properties

    weak var view: UIViewController?

    // MARK: Static methods

    static func setupModule() -> TabBarViewController {
        let viewController = UIStoryboard.loadViewController() as TabBarViewController
        let presenter = TabBarPresenter()
        let router = TabBarRouter()
        let interactor = TabBarInteractor()

        viewController.presenter = presenter

        presenter.view = viewController
        presenter.router = router
        presenter.interactor = interactor

        router.view = viewController

        interactor.output = presenter

        return viewController
    }
}

extension TabBarRouter: TabBarWireframe {
    // TODO: Implement wireframe methods
}
