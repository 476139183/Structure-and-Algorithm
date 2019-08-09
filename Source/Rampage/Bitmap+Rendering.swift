//
//  ConcurrentRenderer.swift
//  Rampage
//
//  Created by Nick Lockwood on 09/08/2019.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import UIKit
import Engine

public extension Bitmap {
    init(width: Int, height: Int, world: World, textures: Textures) {
        let cpuCores = ProcessInfo.processInfo.activeProcessorCount
        var buffers = Array(repeating: [Color](), count: cpuCores)
        let step = 1.0 / Double(cpuCores)
        DispatchQueue.concurrentPerform(iterations: cpuCores) { i in
            let offset = Double(i) * step
            let range = offset ..< offset + step
            var renderer = Renderer(
                width: width,
                height: height,
                range: range,
                textures: textures
            )
            renderer.draw(world)
            buffers[i] = renderer.bitmap.pixels
        }
        let pixels = Array(buffers.joined())
        self.init(height: height, pixels: pixels)
    }
}
