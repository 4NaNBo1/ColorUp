//
//  AdjustmentSlider.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import SwiftUI

struct AdjustmentSlider: View {
    let title: String
    let icon: String
    @Binding var value: Double
    let range: ClosedRange<Double>
    let onChange: () -> Void
    var snapToValues: [Double]? = nil  // 可选：拖动结束后吸附到指定值
    
    @State private var isDragging = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            // 上方：垂直滑条
            GeometryReader { geometry in
                ZStack(alignment: .center) {
                    // 轨道背景
                    Capsule()
                        .fill(Color.white.opacity(0.1))
                        .frame(width: 6)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    
                    // 进度条（从下往上）
                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [.orange, .yellow],
                                startPoint: .bottom,
                                endPoint: .top
                            )
                        )
                        .frame(width: 6, height: progressHeight(in: geometry.size.height))
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    
                    // 滑块手柄
                    Circle()
                        .fill(Color.white)
                        .frame(width: 18, height: 18)
                        .shadow(color: Color.orange.opacity(0.5), radius: 6)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                        .offset(y: -progressHeight(in: geometry.size.height))
                        .allowsHitTesting(false)  // 禁用手柄自身的点击，由外层处理
                }
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            let handleY = geometry.size.height - progressHeight(in: geometry.size.height)
                            let handleTouchRadius: CGFloat = 20
                            
                            // 检查是否在手柄附近开始拖动
                            if !isDragging {
                                // 首次点击，检查是否在手柄附近
                                if abs(gesture.startLocation.y - handleY) <= handleTouchRadius {
                                    isDragging = true
                                }
                            }
                            
                            // 如果正在拖动手柄，则更新值
                            if isDragging {
                                // 垂直拖动，从下往上为正值
                                let newValue = Double(1.0 - (gesture.location.y / geometry.size.height))
                                let clampedValue = max(0, min(1, newValue))
                                value = range.lowerBound + (range.upperBound - range.lowerBound) * clampedValue
                                
                                // 立即触发 onChange，实时更新
                                onChange()
                            }
                        }
                        .onEnded { gesture in
                            let handleY = geometry.size.height - progressHeight(in: geometry.size.height)
                            let handleTouchRadius: CGFloat = 20
                            
                            // 如果是拖动手柄，处理结束逻辑
                            if isDragging {
                                isDragging = false
                                
                                // 如果设置了 snapToValues，吸附到最近的值
                                if let snapValues = snapToValues {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        let closestValue = snapValues.min(by: { abs($0 - value) < abs($1 - value) }) ?? value
                                        value = closestValue
                                    }
                                    onChange()
                                }
                            } else {
                                // 如果是点击轨道（不在手柄附近），跳转值
                                if abs(gesture.location.y - handleY) > handleTouchRadius {
                                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                        let newValue = Double(1.0 - (gesture.location.y / geometry.size.height))
                                        value = range.lowerBound + (range.upperBound - range.lowerBound) * max(0, min(1, newValue))
                                        
                                        // 如果设置了 snapToValues，吸附到最近的值
                                        if let snapValues = snapToValues {
                                            let closestValue = snapValues.min(by: { abs($0 - value) < abs($1 - value) }) ?? value
                                            value = closestValue
                                        }
                                    }
                                    onChange()
                                }
                            }
                        }
                )
            }
            .frame(height: 160)  // 固定高度
            
            // 下方：图标、标题和数值
            VStack(alignment: .center, spacing: 4) {
                HStack(spacing: 4) {
                    Image(systemName: icon)
                        .font(.system(size: 10))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.orange, .yellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text(title)
                        .font(.custom("PingFang SC", size: 11))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                
                // 数值显示
                Text(valueText)
                    .font(.custom("Menlo", size: 10))
                    .fontWeight(.semibold)
                    .foregroundColor(.orange)
                    .padding(.horizontal, 6)
                    .padding(.vertical, 2)
                    .background(
                        Capsule()
                            .fill(Color.orange.opacity(0.2))
                    )
            }
        }
        .frame(width: 50)  // 固定宽度，更窄以适应同屏显示
    }
    
    private func progressHeight(in totalHeight: CGFloat) -> CGFloat {
        let normalizedValue = (value - range.lowerBound) / (range.upperBound - range.lowerBound)
        return totalHeight * normalizedValue
    }
    
    // 根据是否有 snapToValues 来格式化显示值
    private var valueText: String {
        if let snapValues = snapToValues, snapValues.count == 2 && snapValues.contains(0.0) && snapValues.contains(1.0) {
            // 对于开关类型（0/1），显示为整数和状态文字
            return value >= 0.5 ? "1" : "0"
        } else {
            // 正常显示小数
            return String(format: "%.2f", value)
        }
    }
}
