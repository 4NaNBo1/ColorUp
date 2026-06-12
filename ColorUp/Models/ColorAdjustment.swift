//
//  ColorAdjustment.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import Foundation

struct ColorAdjustment: Equatable {
    var hue: Double = 0.0           // 色相: -1.0 ~ 1.0
    var saturation: Double = 1.0    // 饱和度: 0.0 ~ 2.0
    var brightness: Double = 1.0    // 亮度: 0.0 ~ 2.0
    var contrast: Double = 1.0      // 对比度: 0.0 ~ 2.0
    var lutIntensity: Double = 1.0  // LUT强度: 0.0 ~ 1.0
    var exposure: Double = 1.0      // 曝光值: 0.0 ~ 5.0
    var gamma: Double = 2.2         // 伽马矫正系数: 0.1 ~ 3.0
    var useACES: Double = 1.0       // 使用ACES色调映射: 0.0 = 关闭, 1.0 = 开启
    
    // 计算属性：判断是否启用ACES
    var acesEnabled: Bool {
        useACES >= 0.5
    }
    
    // 重置到默认值
    mutating func reset() {
        self = ColorAdjustment()
    }
}
