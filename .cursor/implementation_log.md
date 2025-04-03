- 2023-04-03 17:45: Bug Analysis - Nil pointer dereference in Room GroupedLight [File: cmd/set/set_room.go]

## Bug Identified
A runtime panic occurs in the `set room` command when attempting to call `Set()` on a nil `GroupedLight` pointer. This happens when a room returned by the Hue API doesn't have an associated GroupedLight service.

## Root Cause Analysis
1. The `getRooms` function in `openhue/home_service.go` can set `room.GroupedLight` to nil if `getGroupedLight` returns an error
2. The current implementation in `cmd/set/set_room.go` doesn't check if `room.GroupedLight` is nil before calling its `Set` method
3. When a room without a GroupedLight is targeted, the code attempts to call a method on a nil pointer, causing a panic

## Recommended Fix
Add a nil check in the `set_room.go` command before calling `Set()`:

```go
for _, room := range rooms {
    if room.GroupedLight == nil {
        ctx.Io.ErrPrintln("Warning: Room", room.Name, "does not have a valid GroupedLight, skipping...")
        continue
    }
    room.GroupedLight.Set(o)
}
```

This approach:
- Prevents the nil pointer dereference
- Provides clear feedback to users when a room lacks the required GroupedLight service
- Gracefully continues processing other valid rooms
- Maintains proper error handling practices by reporting the issue instead of silently failing

## Alternative Approaches Considered
Another approach would be to handle the nil receiver in the `GroupedLight.Set` method itself. However, the recommended approach is more explicit about the limitation and keeps the check closer to where the error occurs.
