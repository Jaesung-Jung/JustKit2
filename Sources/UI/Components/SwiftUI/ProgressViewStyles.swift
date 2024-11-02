//
//  ProgressViewStyles.swift
//
//  Copyright © 2024 Jaesung Jung. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SwiftUI

// MARK: - JustLinearProgressViewStyle

struct JustLinearProgressViewStyle: ProgressViewStyle {
  @Environment(\.controlSize) var controlSize

  let thickness: CGFloat?
  let cornerRadius: CGFloat?

  func makeBody(configuration: Configuration) -> some View {
    Content(
      label: configuration.label,
      progress: configuration.fractionCompleted ?? 0,
      thickness: thickness,
      cornerRadius: cornerRadius,
      componentSize: ComponentSize(controlSize)
    )
  }

  struct Content<Label: View>: View {
    let label: Label
    let progress: Double
    let thickness: CGFloat
    let cornerRadius: CGFloat
    let componentSize: ComponentSize

    init(label: Label, progress: Double, thickness: CGFloat?, cornerRadius: CGFloat?, componentSize: ComponentSize) {
      self.label = label
      self.progress = min(max(progress, 0), 1)
      self.componentSize = componentSize
      if let thickness {
        self.thickness = thickness
      } else {
        switch componentSize {
        case .mini:
          self.thickness = 4
        case .small:
          self.thickness = 8
        case .large:
          self.thickness = 16
        case .extraLarge:
          self.thickness = 20
        default:
          self.thickness = 12
        }
      }
      if let cornerRadius {
        self.cornerRadius = cornerRadius
      } else {
        self.cornerRadius = max(4, self.thickness * 0.25)
      }
    }

    var body: some View {
      ZStack(alignment: .leading) {
        Rectangle()
          .fill(.tint.opacity(0.15))

        GeometryReader { geometry in
          Rectangle()
            .fill(.tint)
            .frame(width: geometry.size.width * CGFloat(progress))
        }
      }
      .frame(height: thickness)
      .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
    }
  }
}

// MARK: - JustCircularProgressViewStyle

struct JustCircularProgressViewStyle: ProgressViewStyle {
  @Environment(\.controlSize) var controlSize

  let thickness: CGFloat?

  func makeBody(configuration: Configuration) -> some View {
    Content(
      label: configuration.label,
      progress: configuration.fractionCompleted ?? 0,
      thickness: thickness,
      componentSize: ComponentSize(controlSize)
    )
  }

  struct Content<Label: View>: View {
    let label: Label
    let progress: Double
    let thickness: CGFloat
    let idealHeight: CGFloat

    init(label: Label, progress: Double, thickness: CGFloat?, componentSize: ComponentSize) {
      self.label = label
      self.progress = progress
      if let thickness {
        self.thickness = thickness
      } else {
        switch componentSize {
        case .mini:
          self.thickness = 4
        case .small:
          self.thickness = 8
        case .large:
          self.thickness = 16
        case .extraLarge:
          self.thickness = 20
        default:
          self.thickness = 12
        }
      }
      self.idealHeight = self.thickness * 4
    }

    var body: some View {
      GeometryReader { geometry in
        ZStack {
          Circle()
            .strokeBorder(lineWidth: thickness)
            .foregroundStyle(.tint.opacity(0.15))

          Circle()
            .trim(from: 0, to: CGFloat(progress))
            .stroke(
              style: StrokeStyle(
                lineWidth: thickness,
                lineCap: .round
              )
            )
            .rotationEffect(.degrees(-90))
            .padding(thickness * 0.5)
            .foregroundStyle(.tint)
        }
        .frame(width: min(geometry.size.width, geometry.size.height), height: min(geometry.size.width, geometry.size.height))
      }
    }
  }
}

// MARK: - CircleFadeProgressViewStyle

struct CircleFadeProgressViewStyle: ProgressViewStyle {
  @Environment(\.controlSize) var controlSize

  func makeBody(configuration: Configuration) -> some View {
    Content(
      label: configuration.label,
      componentSize: ComponentSize(controlSize)
    )
  }

  struct Content<Label: View>: View {
    let label: Label
    let componentSize: ComponentSize

    var body: some View {
      VStack {
        ProgressEllipsis(componentSize: componentSize) { circle, flag in
          AnyView(
            circle
              .opacity(flag ? 0.5 : 1)
          )
        }

        label
          .font(componentSize.preferredFont)
      }
      .foregroundStyle(.tertiary)
    }
  }
}

// MARK: - CircleScaleProgressViewStyle

struct CircleScaleProgressViewStyle: ProgressViewStyle {
  @Environment(\.controlSize) var controlSize

  public func makeBody(configuration: Configuration) -> some View {
    Content(
      label: configuration.label,
      componentSize: ComponentSize(controlSize)
    )
  }

  struct Content<Label: View>: View {
    let label: Label
    let componentSize: ComponentSize

    var body: some View {
      VStack {
        ProgressEllipsis(componentSize: componentSize) { circle, flag in
          AnyView(
            circle
              .opacity(flag ? 0.5 : 1)
              .scaleEffect(flag ? CGSize(width: 0.7, height: 0.7) : CGSize(width: 1, height: 1))
          )
        }

        label
          .font(componentSize.preferredFont)
      }
      .foregroundStyle(.tertiary)
    }
  }
}

// MARK: - CircleScaleBottomProgressViewStyle

struct CircleScaleBottomProgressViewStyle: ProgressViewStyle {
  @Environment(\.controlSize) var controlSize

  public func makeBody(configuration: Configuration) -> some View {
    Content(
      label: configuration.label,
      componentSize: ComponentSize(controlSize)
    )
  }

  struct Content<Label: View>: View {
    let label: Label
    let componentSize: ComponentSize

    var body: some View {
      VStack {
        ProgressEllipsis(componentSize: componentSize) { circle, flag in
          AnyView(
            circle
              .opacity(flag ? 0.5 : 1)
              .scaleEffect(flag ? CGSize(width: 0.7, height: 0.7) : CGSize(width: 1, height: 1), anchor: .bottom)
          )
        }

        label
          .font(componentSize.preferredFont)
      }
      .foregroundStyle(.tertiary)
    }
  }
}

// MARK: - ProgressEllipsis

struct ProgressEllipsis: View {
  let size: CGFloat
  let modifier: (Circle, Bool) -> AnyView
  let animation = Animation.easeInOut(duration: 0.5).repeatForever(autoreverses: true)

  init(componentSize: ComponentSize, modifier: @escaping (Circle, Bool) -> AnyView) {
    switch componentSize {
    case .mini:
      size = 6
    case .small:
      size = 8
    case .large:
      size = 16
    case .extraLarge:
      size = 20
    default:
      size = 12
    }
    self.modifier = modifier
  }

  var body: some View {
    HStack(spacing: size / 2) {
      CircleItem(size: size, animation: animation, modifier: modifier)
      CircleItem(size: size, animation: animation.delay(0.25), modifier: modifier)
      CircleItem(size: size, animation: animation.delay(0.5), modifier: modifier)
    }
  }

  struct CircleItem: View {
    @State var flag = true

    let size: CGFloat
    let animation: Animation
    let modifier: (Circle, Bool) -> AnyView

    var body: some View {
      modifier(Circle(), flag)
        .frame(width: size, height: size)
        .onAppear {
          withAnimation(animation) {
            flag.toggle()
          }
        }
    }
  }
}

// MARK: - ProgressViewStyle (Just)

extension ProgressViewStyle where Self == JustProgressViewStyles {
  public static var just: JustProgressViewStyles.Type { JustProgressViewStyles.self }
}

public struct JustProgressViewStyles: ProgressViewStyle {
  public static func linear(thickness: CGFloat? = nil, cornerRadius: CGFloat? = nil) -> some ProgressViewStyle {
    JustLinearProgressViewStyle(thickness: thickness, cornerRadius: cornerRadius)
  }

  public static func circular(thickness: CGFloat? = nil) -> some ProgressViewStyle {
    JustCircularProgressViewStyle(thickness: thickness)
  }

  public static var circleFade: some ProgressViewStyle { CircleFadeProgressViewStyle() }

  public static var circleScale: some ProgressViewStyle { CircleScaleProgressViewStyle() }

  public static var circleScaleBottom: some ProgressViewStyle { CircleScaleBottomProgressViewStyle() }

  public func makeBody(configuration: Configuration) -> some View {
    EmptyView()
  }
}

// MARK: - ProgressViewStyles Preview

@available(iOS 17.0, macCatalyst 17.0, tvOS 17.0, watchOS 10.0, *)
#Preview {
  let header: (String) -> some View = {
    Text($0)
      .font(.caption)
      .fontDesign(.monospaced)
      .textCase(nil)
      .padding(4)
      .foregroundStyle(.tint)
      .background(.tint.opacity(0.12))
      .cornerRadius(4)
      .listRowInsets(EdgeInsets(bottom: 8))
  }
  let progressViews: () -> some View = {
    ForEach(ControlSize.allCases, id: \.self) { controlSize in
      HStack {
        ProgressView(value: 0.5)
          .controlSize(controlSize)
        Spacer()
        Text("\(controlSize)")
          .font(ComponentSize(controlSize).preferredFont)
      }
    }
  }
  return NavigationStack {
    List {
      Section {
        progressViews().progressViewStyle(.just.linear())
      } header: {
        header(".just.linear")
      }
      .listRowSeparator(.hidden)

      Section {
        progressViews().progressViewStyle(.just.circular())
      } header: {
        header(".just.circular")
      }
      .listRowSeparator(.hidden)

      Section {
        progressViews().progressViewStyle(.just.circleFade)
      } header: {
        header(".just.circleFade")
      }
      .listRowSeparator(.hidden)

      Section {
        progressViews().progressViewStyle(.just.circleScale)
      } header: {
        header(".just.circleScale")
      }
      .listRowSeparator(.hidden)

      Section {
        progressViews().progressViewStyle(.just.circleScaleBottom)
      } header: {
        header(".just.circleScaleBottom")
      }
      .listRowSeparator(.hidden)
    }
    .navigationTitle("ProgressView Preview")
  }
}
