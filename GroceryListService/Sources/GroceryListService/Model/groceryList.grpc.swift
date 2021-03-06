//
// DO NOT EDIT.
//
// Generated by the protocol buffer compiler.
// Source: groceryList.proto
//

//
// Copyright 2018, gRPC Authors All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
import Foundation
import GRPC
import NIO
import NIOHTTP1
import SwiftProtobuf

/// To build a server, implement a class that conforms to this protocol.
internal protocol GroceryList_GroceryListProvider: CallHandlerProvider {
  /// Sends a greeting.
  func get(request: GroceryList_Empty, context: StatusOnlyCallContext) -> EventLoopFuture<GroceryList_GroceryListReply>
}

extension GroceryList_GroceryListProvider {
  internal var serviceName: String { return "groceryList.GroceryList" }

  /// Determines, calls and returns the appropriate request handler, depending on the request's method.
  /// Returns nil for methods not handled by this service.
  internal func handleMethod(_ methodName: String, callHandlerContext: CallHandlerContext) -> GRPCCallHandler? {
    switch methodName {
    case "get":
      return UnaryCallHandler(callHandlerContext: callHandlerContext) { context in
        return { request in
          self.get(request: request, context: context)
        }
      }

    default: return nil
    }
  }
}


// Provides conformance to `GRPCPayload`
extension GroceryList_Empty: GRPCProtobufPayload {}
extension GroceryList_Item: GRPCProtobufPayload {}
extension GroceryList_GroceryListReply: GRPCProtobufPayload {}
