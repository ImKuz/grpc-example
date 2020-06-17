//
//  GroceryListService.swift
//  GroceryListClient
//
//  Created by Mikhail Kuzmin on 17.06.2020.
//  Copyright © 2020 Mikhail Kuzmin All rights reserved.
//

import Combine
import GRPC
import NIO

protocol GroceryListService {

    func getItems() -> AnyPublisher<[GroceryList_Item], Error>

}

final class GroceryListServiceImpl {

    let client: GroceryList_GroceryListClient

    init(host: String, port: Int) {
        let group = PlatformSupport.makeEventLoopGroup(loopCount: 1)
        let channel = ClientConnection
            .insecure(group: group)
            .connect(host: host, port: port)

        client = GroceryList_GroceryListClient(channel: channel)
    }

}

extension GroceryListServiceImpl: GroceryListService {

    func getItems() -> AnyPublisher<[GroceryList_Item], Error> {
        let subject = PassthroughSubject<[GroceryList_Item], Error>()

        let call = client.get(GroceryList_Empty())

        call.response.whenSuccess { result in
            subject.send(result.items)
        }

        call.response.whenFailure { error in
            print("Error: \(error.localizedDescription)")

            subject.send(completion: .failure(error))
        }

        return subject.eraseToAnyPublisher()
    }

}
