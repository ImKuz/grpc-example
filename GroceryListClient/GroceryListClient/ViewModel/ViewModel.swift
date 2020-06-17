import Combine
import Foundation

struct ViewModelOutput {

    let items: AnyPublisher<[GroceryList_Item], Error>

}

protocol ViewModel {

    func transform() -> ViewModelOutput

}

final class ViewModelImpl: ViewModel {

    let groceryListService: GroceryListService

    init(groceryListService: GroceryListService) {
        self.groceryListService = groceryListService
    }

    func transform() -> ViewModelOutput {
        .init(items: groceryListService.getItems())
    }

}
