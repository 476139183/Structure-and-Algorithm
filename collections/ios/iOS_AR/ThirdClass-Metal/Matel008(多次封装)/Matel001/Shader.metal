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

//! 处理输入数据的结构体
struct VertexIn {
  
  float4 position[[ attribute(0)]];
  float4 color [[ attribute(1)]];
  
};

//!
struct VertexOut {
  
  float4 position [[position]];
  float4 color;
};


/* !
 * vertexIn 接收第一个结构体
 *
 */
vertex VertexOut vertex_shader(const VertexIn vertexIn [[stage_in]]) {
  
  VertexOut vertexOut;
  vertexOut.position = vertexIn.position;
  vertexOut.color = vertexIn.color;
  
  
  return vertexOut;
}



////! 着色
fragment half4 fragment_shader(VertexOut vertexIn[[ stage_in]]) {
  
  /* //! 返回灰色
  float grauColor = (vertexIn.color.r + vertexIn.color.g + vertexIn.color.b) / 3.0;
  
  return half4(grauColor,grauColor,grauColor,1);
   */
  
  //! 黄色
  return half4(vertexIn.color);
}
