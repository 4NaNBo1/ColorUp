//
//  PresetStyleSelector.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import SwiftUI

struct PresetStyleSelector: View {
    @Binding var selectedPreset: StylePreset?
    let onPresetSelected: (StylePreset) -> Void
    
    @State private var selectedCategory: String = "全部"
    @Namespace private var animation
    
    private var categories: [String] {
        ["全部"] + StylePreset.categories
    }
    
    private var filteredPresets: [StylePreset] {
        if selectedCategory == "全部" {
            return StylePreset.presets
        }
        return StylePreset.presets.filter { $0.category == selectedCategory }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // 分类选择器
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(categories, id: \.self) { category in
                        CategoryPill(
                            title: category,
                            isSelected: selectedCategory == category,
                            namespace: animation
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedCategory = category
                            }
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            // 预设网格 - 使用垂直滚动的网格布局
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: [
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12),
                    GridItem(.flexible(), spacing: 12)
                ], spacing: 12) {
                    ForEach(filteredPresets) { preset in
                        PresetCard(
                            preset: preset,
                            isSelected: selectedPreset?.id == preset.id
                        )
                        .onTapGesture {
                            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                                selectedPreset = preset
                                onPresetSelected(preset)
                            }
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
        }
    }
}

struct CategoryPill: View {
    let title: String
    let isSelected: Bool
    let namespace: Namespace.ID
    
    var body: some View {
        Text(title)
            .font(.custom("PingFang SC", size: 12))
            .fontWeight(isSelected ? .bold : .regular)
            .foregroundColor(isSelected ? .black : .white)
            .padding(.horizontal, 14)
            .padding(.vertical, 6)
            .background(
                Group {
                    if isSelected {
                        Capsule()
                            .fill(
                                LinearGradient(
                                    colors: [.orange, .yellow],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .matchedGeometryEffect(id: "category", in: namespace)
                    } else {
                        Capsule()
                            .strokeBorder(Color.white.opacity(0.3), lineWidth: 1)
                    }
                }
            )
    }
}

struct PresetCard: View {
    let preset: StylePreset
    let isSelected: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            // 预览色块 - 调小尺寸
            RoundedRectangle(cornerRadius: 8)
                .fill(
                    LinearGradient(
                        colors: previewColors,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .aspectRatio(4/3, contentMode: .fit)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .strokeBorder(
                            isSelected ? Color.orange : Color.clear,
                            lineWidth: 2
                        )
                )
            
            VStack(alignment: .center, spacing: 2) {
                Text(preset.name)
                    .font(.custom("PingFang SC", size: 11))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                
                Text(preset.nameEN)
                    .font(.custom("Menlo", size: 8))
                    .foregroundColor(.gray)
                    .lineLimit(1)
                    .minimumScaleFactor(0.7)
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial)
                .shadow(color: isSelected ? Color.orange.opacity(0.5) : Color.black.opacity(0.2),
                       radius: isSelected ? 10 : 3,
                       x: 0,
                       y: isSelected ? 3 : 1)
        )
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
    }
    
    private var previewColors: [Color] {
        let adj = preset.adjustment
        
        // 根据饱和度和色相生成预览颜色
        let hue = (adj.hue + 1.0) / 2.0 // 转换到 0-1 范围
        let saturation = adj.saturation / 2.0 // 归一化
        let brightness = adj.brightness / 2.0 // 归一化
        
        if adj.saturation < 0.2 {
            // 黑白风格
            return [.gray, .white, .black]
        } else if adj.hue > 0.5 {
            // 偏向蓝紫色
            return [.purple, .blue, .cyan]
        } else if adj.hue < -0.02 {
            // 偏向冷色调
            return [.blue, .cyan, .teal]
        } else if adj.hue > 0.05 {
            // 偏向暖色调
            return [.orange, .yellow, .red]
        } else {
            // 默认渐变
            return [.orange.opacity(saturation), .blue.opacity(brightness), .purple.opacity(saturation)]
        }
    }
}
