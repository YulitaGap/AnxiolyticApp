//
//  TabBarPresenter.swift
//  Anxiolytic
//
//  Created by Yulia Gapunovych on 08.05.2022.
//  
//

import Foundation

class TabBarPresenter {

    // MARK: Properties

    weak var view: TabBarView?
    var router: TabBarWireframe?
    var interactor: TabBarUseCase?
}

extension TabBarPresenter: TabBarPresentation {
    // TODO: implement presentation methods
}

extension TabBarPresenter: TabBarInteractorOutput {
    // TODO: implement interactor output methods
}
