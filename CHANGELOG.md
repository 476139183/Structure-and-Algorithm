## Change Log

Occasionally bugs happen, and given the episodic nature of this tutorial, it is difficult to address these retrospectively without changing the Git commit history.

This file is a record of bugs that have been found and fixed since the tutorial started. The dates next to each bug indicate when the fix was merged. If you completed the relevant tutorial(s) after the date listed for a given bug, you can safely ignore it.


### Wall Collisions (2019/19/08)

The original wall collision detection code described in [Part 2](Tutorial/Part2.md) had a bug that could cause the player to stick when sliding along a wall (thanks to [José Ibañez](https://twitter.com/jose_ibanez/status/1163225777401401344?s=20) for reporting).

The fix for this was to return the largest intersection detected between any wall segment, rather than just the first intersection detected. The necessary code changes are in `Actor.intersection(with map:)`, which should now look like this:

```swift
func intersection(with map: Tilemap) -> Vector? {
    let minX = Int(rect.min.x), maxX = Int(rect.max.x)
    let minY = Int(rect.min.y), maxY = Int(rect.max.y)
    var largestIntersection: Vector?
    for y in minY ... maxY {
        for x in minX ... maxX where map[x, y].isWall {
            let wallRect = Rect(
                min: Vector(x: Double(x), y: Double(y)),
                max: Vector(x: Double(x + 1), y: Double(y + 1))
            )
            if let intersection = rect.intersection(with: wallRect),
                intersection.length > largestIntersection?.length ?? 0 {
                largestIntersection = intersection
            }
        }
    }
    return largestIntersection
}
```

### Sprite Rendering (2019/02/08)

In the original version of [Part 5](Tutorial/Part5.md) there were a couple of bugs in the sprite texture coordinate calculation. In your own project, check if the `// Draw sprites` section in `Renderer.swift` contains the following two lines:

```swift
let textureX = Int(spriteX * Double(wallTexture.width))
let spriteTexture = textures[sprite.texture]
```

If so, replace them with:

```swift
let spriteTexture = textures[sprite.texture]
let textureX = min(Int(spriteX * Double(spriteTexture.width)), spriteTexture.width - 1)
```

### Texture Capitalization (2019/07/28)

This isn't exactly a bug, but the capitalization of texture image keys changed from `lowercase` to `camelCase` after [Part 5](Tutorial/Part5.md) was released. If you've been using the tutorial textures in your own project, watch out for this when updating as some of the asset file names may not match up with the keys in `Textures.swift`.
