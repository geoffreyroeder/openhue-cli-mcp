# OpenHue CLI Architecture Diagrams

## Core Components UML

```mermaid
classDiagram
    class Context {
        +IOStreams Io
        +BuildInfo BuildInfo
        +Home Home
        +Config Config
    }
    
    class HomeModel {
        +Resource Resource
        +[]Room Rooms
        +[]Device Devices
        +BridgeHomeGet HueData
    }
    
    class Resource {
        +string Id
        +string Name
        +HomeResourceType Type
        +Resource Parent
    }
    
    class Room {
        +Resource Resource
        +[]Device Devices
        +[]Scene Scenes
        +GroupedLight GroupedLight
    }
    
    class Device {
        +Resource Resource
        +Light Light
    }
    
    class Light {
        +Resource Resource
        +LightService LightService
        +LightGet HueData
    }
    
    Context --> HomeModel
    HomeModel --> Resource
    Room --> Resource
    Device --> Resource
    Light --> Resource
```

## Command Flow

```mermaid
sequenceDiagram
    participant User
    participant CLI
    participant Context
    participant HomeModel
    participant Bridge
    
    User->>CLI: Executes command
    CLI->>Context: Loads configuration
    Context->>Bridge: Authenticates
    Bridge-->>Context: Returns home data
    Context->>HomeModel: Creates model
    HomeModel-->>CLI: Returns structured data
    CLI->>User: Displays results
```

## Data Flow

```mermaid
graph TD
    A[User Command] --> B[CLI Parser]
    B --> C[Command Handler]
    C --> D[Context Loader]
    D --> E[Bridge API]
    E --> F[HomeModel Builder]
    F --> G[Resource Processor]
    G --> H[Response Formatter]
    H --> I[User Output]
```

## Configuration Flow

```mermaid
graph LR
    A[Setup Command] --> B[Bridge Discovery]
    B --> C[User Authentication]
    C --> D[Config Save]
    D --> E[Config Load]
    E --> F[API Client Creation]
```

## Error Handling Flow

```mermaid
graph TD
    A[Command Execution] --> B{Error?}
    B -->|Yes| C[Error Handler]
    B -->|No| D[Success Path]
    C --> E[Error Formatter]
    E --> F[User Output]
```

## Project Structure

```mermaid
graph TD
    A[openhue-cli] --> B[cmd]
    A --> C[openhue]
    A --> D[util]
    
    B --> B1[get]
    B --> B2[set]
    B --> B3[setup]
    B --> B4[version]
    
    C --> C1[gen]
    C --> C2[test]
    
    D --> D1[color]
    D --> D2[logger]
    D --> D3[metrics]
```

## Room Discovery and Light Control Flow

```mermaid
sequenceDiagram
    participant User
    participant CLI
    participant Context
    participant HomeModel
    participant Bridge
    
    %% Discover Rooms Flow
    User->>CLI: openhue get room
    CLI->>Context: LoadHomeIfNeeded()
    Context->>Bridge: GetBridgeHome()
    Bridge-->>Context: Returns bridge home data
    Context->>Bridge: GetRooms()
    Bridge-->>Context: Returns rooms data
    Context->>Bridge: GetDevices(), GetLights(), etc.
    Bridge-->>Context: Returns additional data
    Context->>HomeModel: LoadHome()
    HomeModel->>HomeModel: getRooms()
    HomeModel->>HomeModel: getDevices()
    HomeModel-->>Context: Populated HomeModel
    Context->>CLI: SearchRooms()
    CLI->>User: Display room list
    
    %% Turn Off Lights in Room
    User->>CLI: openhue set room "Living Room" --off
    CLI->>Context: LoadHomeIfNeeded()
    Note over Context,HomeModel: Home already loaded
    Context->>HomeModel: SearchRooms("Living Room")
    HomeModel-->>CLI: Room with GroupedLight
    CLI->>HomeModel: room.GroupedLight.Set(LightStatusOff)
    HomeModel->>Bridge: UpdateGroupedLight(id, {on: false})
    Bridge-->>HomeModel: Success response
    HomeModel-->>CLI: Success
    CLI->>User: Command completed
```

## CLI Interface Examples

```mermaid
sequenceDiagram
    participant User
    participant CLI
    
    %% Discover Rooms Flow with Output
    User->>CLI: $ openhue get room
    Note over CLI: Processing Command
    CLI-->>User: ID                                      Name          Type   Status  Brightness<br>aa31ba26-98a7-4830-8ae9-1b7caa8b5700  Living Room   living_room  [on]   85%<br>7d7c9405-bcc0-4f94-9c1a-d2e5c39e59ad  Kitchen      kitchen     [  ]   N/A<br>3b87f749-96e1-4906-a372-30c21e7f36c5  Bedroom      bedroom     [on]   60%
    
    %% Get Room Details with Output
    User->>CLI: $ openhue get room "Living Room" --json
    Note over CLI: Processing Command
    CLI-->>User: {<br>  "Id": "aa31ba26-98a7-4830-8ae9-1b7caa8b5700",<br>  "Name": "Living Room",<br>  "Type": "room",<br>  "Devices": [<br>    { "Id": "15f51223-1e83-4e48-9158-0c20dbd5734e", "Name": "Hue Play Left" },<br>    { "Id": "83111103-a3eb-40c5-b22a-02deedd21fcb", "Name": "Hue Play Right" }<br>  ],<br>  "GroupedLight": {<br>    "Id": "afc61613-7b89-4633-a3f5-8ac94eca31ab",<br>    "Status": "on",<br>    "Brightness": 85<br>  }<br>}
    
    %% Turn Off Room Lights
    User->>CLI: $ openhue set room "Living Room" --off
    Note over CLI: Processing Command
    CLI-->>User: Command completed successfully
    
    %% Error Case - Room Not Found
    User->>CLI: $ openhue set room "Non-existent Room" --off
    Note over CLI: Processing Command
    CLI-->>User: Error: no room(s) found for given ID(s) [Non-existent Room]
``` 