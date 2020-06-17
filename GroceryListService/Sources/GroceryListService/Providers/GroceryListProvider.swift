import GRPC
import NIO

class GroceryListProvider: GroceryList_GroceryListProvider {

    private var items: [GroceryList_Item] = [
        GroceryList_Item.with { $0.title = "Milk" },
        GroceryList_Item.with { $0.title = "Bread" },
        GroceryList_Item.with { $0.title = "Bananas" },
        GroceryList_Item.with { $0.title = "Eggs" },
    ]

    func get(
        request: GroceryList_Empty,
        context: StatusOnlyCallContext
    ) -> EventLoopFuture<GroceryList_GroceryListReply> {
        context.eventLoop.makeSucceededFuture(
            GroceryList_GroceryListReply.with {
                $0.items = items
            }
        )
    }

}
