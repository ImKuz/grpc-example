# Primitive example of gRPC Swift integration
### Server
[GroceryListService](./GroceryListService)
The server is just a primitive gRPC driven web-server developed in Swift.
It has single request which just replay with hardcoded list of items.

Build server:
```
# macOS
$ cd GroceryListService
$ swift build && swift run
```

Both client and server build on SwiftNIO based framework [grpc-swift](https://github.com/grpc/grpc-swift)
### Client
[GroceryListClient](./GroceryListClient)
The client is extremly simple iOS 13 app developed in Swift using UIKit+Combine and MVVM pattern.
### Motivation
I just was wondering how gRPC stack works in Swift and how convinient to integrate it.
Hope someone will find it useful. 

### Brief description of .proto compilation process
First of all install protoc compliator.
```
$ brew install protobuf
```
Clone [grpc-swift](https://github.com/grpc/grpc-swift.git) repo in order to achieve plugins for swift files compilation. Then build them and install.
```
# in grpc-swift directory
$ make plugins
$ sudo cp protoc-gen-swift protoc-gen-grpc-swift /usr/local/bin
```
Now we can complie .proto files
```
$ protoc <your proto> \ 
    --swift_out=. \
    --grpc-swift_opt=Client=true,Server=false \
    --grpc-swift_out=. # output directory
```
Few notes: 
`--swift_out=` - This option in charge of `.pb.swift` files which contains structures representing protobuf `message` objects.

`--grpc-swift_opt=` - This option in charge of options for compilation of `.grpc.swift` files which contains protocols of Client-Server communication.
`--grpc-swift_out=` - Output directory for these files

Now you may use them for build gRPC client or server in Swift.
For more details see [grpc-swift](https://github.com/grpc/grpc-swift) docs or [GroceryListClient](./GroceryListClient)/[GroceryListService](./GroceryListService) source files.

### Author
Mikhail Kuzmin 

mkuzmin231@gmail.com
