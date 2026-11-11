//
//  Shader.metal
//  Matel001
//
//  Created by Yutian Duan on 2020/5/18.
//  Copyright © 2020年 duanyutian. All rights reserved.
//

#include <metal_stdlib>
using namespace metal;


/* ! 顶点
 

 */
vertex float4 vertex_shader(const device packed_float3 * vertices[[buffer(0)]], uint vertexId[[vertex_id]]) {
  
  return float4(vertices[vertexId],1);
  
}

//! 着色
fragment half4 fragment_shader() {
  //! 红色
  return half4(1,0,0,1);
}
