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
  float2 textureCoordinates [[ attribute(2) ]];
};

//!
struct VertexOut {
  
  float4 position [[position]];
  float4 color;
  float2 textureCoordinates;

};


/* !
 * vertexIn 接收第一个结构体
 *
 */
vertex VertexOut vertex_shader(const VertexIn vertexIn [[stage_in]]) {
  
  VertexOut vertexOut;
  vertexOut.position = vertexIn.position;
  vertexOut.color = vertexIn.color;
  vertexOut.textureCoordinates = vertexIn.textureCoordinates;
  
  return vertexOut;
}

////! 着色
fragment half4 fragment_shader(VertexOut vertexIn[[ stage_in]]) {
  //! 黄色
  return half4(vertexIn.color);
}

///! 第二种片元着色器
fragment half4 texture_shader(VertexOut vertexIn[[ stage_in]],
                              texture2d<float>texture [[ texture(0) ]],
                              sampler sampler2D [[sampler(0)]] ) {
  
  ///! 使用自定义的采样器
  float4 color = texture.sample(sampler2D,vertexIn.textureCoordinates);
  
  return half4(color.r,color.g,color.b,1);
}
