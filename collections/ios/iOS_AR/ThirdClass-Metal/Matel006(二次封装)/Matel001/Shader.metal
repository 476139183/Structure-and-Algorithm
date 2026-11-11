//
//  Shader.metal
//  Matel001
//
//  Created by Yutian Duan on 2020/5/18.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;
//! 结构体一致
struct Constants {
  float animateBy;
};

/* ! 顶点
 
constant 告诉 CPU 这个数据是在恒定的空间
 buffer(0), buffer(1),根据编号，拿缓冲区
 */
vertex float4 vertex_shader(const device packed_float3 * vertices[[buffer(0)]],
                            constant Constants &constants[[buffer(1)]],
                            uint vertexId[[vertex_id]]) {
  
  float4 position = float4(vertices[vertexId],1);
  
  position.x += constants.animateBy;
  return position;
}

//! 着色
fragment half4 fragment_shader() {
  //! 黄色
  return half4(1,1,0,1);
}
