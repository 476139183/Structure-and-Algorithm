//
//  CoreAnimationView.swift
//  Rampage
//
//  Created by Nick Lockwood on 17/07/2019.
//  Copyright © 2019 Nick Lockwood. All rights reserved.
//

import UIKit
import Engine

enum Orientation {
    case up
    case down
    case forwards
    case backwards
    case left
    case right
}

class CoreAnimationView: UIView {
    private var layerPool: [CALayer] = []

    override class var layerClass: AnyClass {
        return CATransformLayer.self
    }

    func draw(_ world: World) {
        // Fill layer pool
        layerPool = layer.sublayers ?? []

        // Disable implicit animations
        CATransaction.setDisableActions(true)

        // Transform view
        let scale = bounds.height
        var viewTransform = CATransform3DIdentity
        viewTransform.m34 = 1 / -500
        viewTransform = CATransform3DTranslate(viewTransform, 0, 0, scale)
        let angle = atan2(world.player.direction.x, -world.player.direction.y)
        viewTransform = CATransform3DRotate(viewTransform, CGFloat(angle), 0, 1, 0)
        viewTransform = CATransform3DTranslate(
            viewTransform,
            CGFloat(-world.player.position.x) * scale,
            0,
            CGFloat(-world.player.position.y) * scale
        )
        layer.transform = viewTransform

        // Draw map
        let map = world.map
        for y in 0 ..< map.height {
            for x in 0 ..< map.width {
                let tile = map[x, y]
                let position = CGPoint(x: x, y: y)
                if tile.isWall {
                    if y > 0, !map[x, y - 1].isWall {
                        let texture = world.isDoor(at: x, y - 1) ? .doorjamb2 : tile.textures[1]
                        addLayer(for: texture, at: transform(for: position, .backwards))
                    }
                    if y < map.height - 1, !map[x, y + 1].isWall {
                        let texture = world.isDoor(at: x, y + 1) ? .doorjamb2 : tile.textures[1]
                        addLayer(for: texture, at: transform(for: position, .forwards))
                    }
                    if x > 0, !map[x - 1, y].isWall {
                        let texture = world.isDoor(at: x - 1, y) ? .doorjamb : tile.textures[0]
                        addLayer(for: texture, at: transform(for: position, .left))
                    }
                    if x < map.width - 1, !map[x + 1, y].isWall {
                        let texture = world.isDoor(at: x + 1, y) ? .doorjamb : tile.textures[0]
                        addLayer(for: texture, at: transform(for: position, .right))
                    }
                } else {
                    addLayer(for: tile.textures[0], at: transform(for: position, .up))
                    addLayer(for: tile.textures[1], at: transform(for: position, .down))
                }
            }
        }

        // Draw sprites
        for sprite in world.sprites {
            let center = sprite.start + (sprite.end - sprite.start) / 2
            var spriteTransform = CATransform3DMakeTranslation(
                CGFloat(center.x) * scale,
                0,
                CGFloat(center.y) * scale
            )
            let angle = atan2(-sprite.direction.y, sprite.direction.x)
            spriteTransform = CATransform3DRotate(spriteTransform, CGFloat(angle), 0, 1, 0)
            addLayer(for: sprite.texture, at: spriteTransform, doubleSided: true)
        }

        // Draw player weapon
        addLayer(for: world.player.animation.texture, at: CATransform3DTranslate(
            CATransform3DInvert(self.layer.transform), 0, 0, 4900
        ))

        // Draw effects
        for effect in world.effects {
            switch effect.type {
            case .fadeIn:
                addOverlay(color: effect.color, opacity: 1 - effect.progress)
            case .fadeOut, .fizzleOut:
                addOverlay(color: effect.color, opacity: effect.progress)
            }
        }

        // Remove unused layers
        layerPool.forEach { $0.removeFromSuperlayer() }
    }

    func transform(for position: CGPoint, _ orientation: Orientation) -> CATransform3D {
        let scale = bounds.height
        var transform = CATransform3DMakeTranslation(position.x * scale, 0, position.y * scale)
        switch orientation {
        case .up:
            transform = CATransform3DTranslate(transform, 0.5 * scale, 0.5 * scale, 0.5 * scale)
            transform = CATransform3DRotate(transform, .pi / 2, 1, 0, 0)
        case .down:
            transform = CATransform3DTranslate(transform, 0.5 * scale, -0.5 * scale, 0.5 * scale)
            transform = CATransform3DRotate(transform, -.pi / 2, 1, 0, 0)
        case .backwards:
            transform = CATransform3DTranslate(transform, 0.5 * scale, 0, 0)
            transform = CATransform3DRotate(transform, .pi, 0, 1, 0)
        case .forwards:
            transform = CATransform3DTranslate(transform, 0.5 * scale, 0, scale)
        case .left:
            transform = CATransform3DTranslate(transform, 0, 0, 0.5 * scale)
            transform = CATransform3DRotate(transform, -.pi / 2, 0, 1, 0)
        case .right:
            transform = CATransform3DTranslate(transform, scale, 0, 0.5 * scale)
            transform = CATransform3DRotate(transform, .pi / 2, 0, 1, 0)
        }
        return transform
    }

    func addLayer() -> CALayer {
        var layer: CALayer! = layerPool.popLast()
        if layer == nil {
            layer = CALayer()
            layer.magnificationFilter = .nearest
            layer.isDoubleSided = false
            self.layer.addSublayer(layer)
        }
        layer.contents = nil
        layer.backgroundColor = nil
        return layer
    }

    func addLayer(for texture: Texture, at transform: CATransform3D, doubleSided: Bool = false) {
        let layer = addLayer()
        let scale = bounds.height
        layer.bounds.size = CGSize(width: scale, height: scale)
        layer.contents = UIImage(named:texture.rawValue)?.cgImage
        layer.position = CGPoint(x: bounds.midX, y: bounds.midY)
        layer.isDoubleSided = doubleSided
        layer.transform = transform
    }

    func addOverlay(color: Color, opacity: Double) {
        let layer = addLayer()
        layer.transform = CATransform3DTranslate(
            CATransform3DInvert(self.layer.transform), 0, 0, 5000
        )
        layer.frame = bounds
        layer.backgroundColor = UIColor(
            red: CGFloat(color.r) / 255,
            green: CGFloat(color.g) / 255,
            blue: CGFloat(color.b) / 255,
            alpha: CGFloat(color.a) / 255 * CGFloat(opacity)
        ).cgColor
    }
}
