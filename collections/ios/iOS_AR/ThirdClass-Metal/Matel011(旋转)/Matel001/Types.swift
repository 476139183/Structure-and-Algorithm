//
//  Types.swift
//  Matel001
//
//  Created by Yutian Duan on 2020/5/19.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

import Foundation
import simd


//! 描述 顶点xyz 和 颜色rgba + 纹理2d
struct Vertex {
  
  var position: float3
  var color: float4
  var texture: float2
  
}

// 模型矩阵
struct ModelConstants {
  // 4x4  视图矩阵
  var modelViewMatrix = matrix_identity_float4x4
  
  
}

