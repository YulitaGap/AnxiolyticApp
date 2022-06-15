import UIKit

/**
  Stores all the models related to the `AddAttackViewController`.
  The `AddAttackViewModel's` class will be related to each component.
  The view model will contain Request, Response and ViewModel structs.
 */
struct AddAttackViewModel {

    static let questionsTableSectionsAmount = 1
    static let questionsTableCellsAmount = questionsData.count

    static let questionsData = [
        "My heart beats really fast",
        "I feel afraid",
        "I have trouble breathing",
        "I lose focus",
        "My voice trembles",
        "I start to sweat a lot",
        "My stomach or head starts to hurt",
        "I feel like running away",
        "My mind goes really fast",
        "I get really jumpy",
        "I think something bad may happen",
        "I get a lump in my throat",
        "My chest starts to feel tight",
        "I feel out of control"
    ]
}
