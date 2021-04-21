import UIKit

extension CGFloat {

    public static var zero: CGFloat {
        return 0
    }

}

extension UIView {

    public func anchor(leading: NSLayoutXAxisAnchor? = nil,
                       trailing: NSLayoutXAxisAnchor? = nil,
                       top: NSLayoutYAxisAnchor? = nil,
                       bottom: NSLayoutYAxisAnchor? = nil,
                       paddingLeading: CGFloat = .zero,
                       paddingTrailing: CGFloat = .zero,
                       paddingTop: CGFloat = .zero,
                       paddingBottom: CGFloat = .zero,
                       width: CGFloat = .zero,
                       height: CGFloat = .zero) {

        guard !translatesAutoresizingMaskIntoConstraints else {
            assertionFailure("Turn off AutoresizingMask first")
            return
        }

        var constraints = [NSLayoutConstraint]()

        if let top = top {
            constraints.append(topAnchor.constraint(equalTo: top, constant: paddingTop))
        }
        if let leading = leading {
            constraints.append(leadingAnchor.constraint(equalTo: leading,
                                                        constant: paddingLeading))
        }
        if let bottom = bottom {
            constraints.append(bottomAnchor.constraint(equalTo: bottom,
                                                       constant: paddingBottom))
        }
        if let trailing = trailing {
            constraints.append(trailingAnchor.constraint(equalTo: trailing,
                                                         constant: paddingTrailing))
        }
        if width != .zero {
            constraints.append(widthAnchor.constraint(equalToConstant: width))
        }
        if height != .zero {
            constraints.append(heightAnchor.constraint(equalToConstant: height))
        }

        NSLayoutConstraint.activate(constraints)
    }

    public func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }
        anchor(leading: superview.safeAreaLayoutGuide.leadingAnchor,
               trailing: superview.safeAreaLayoutGuide.trailingAnchor,
               top: superview.safeAreaLayoutGuide.topAnchor,
               bottom: superview.safeAreaLayoutGuide.bottomAnchor,
               paddingLeading: padding.left,
               paddingTrailing: padding.right,
               paddingTop: padding.top,
               paddingBottom: padding.bottom,
               width: .zero,
               height: .zero)
    }

    public func centerVertically(to constraint: NSLayoutYAxisAnchor? = nil,
                                 constant: CGFloat = .zero) {
        guard !translatesAutoresizingMaskIntoConstraints else {
            assertionFailure("Turn off AutoresizingMask first")
            return
        }

        if let constraint = constraint {
            centerYAnchor.constraint(equalTo: constraint,
                                     constant: constant).isActive = true
        }
        else if let superview = superview {
            centerYAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.centerYAnchor,
                                     constant: constant).isActive = true
        }
    }

    public func centerHorizontally(to constraint: NSLayoutXAxisAnchor? = nil,
                                   constant: CGFloat = 0) {
        guard !translatesAutoresizingMaskIntoConstraints else {
            assertionFailure("Turn off AutoresizingMask first")
            return
        }

        if let constraint = constraint {
            centerXAnchor.constraint(equalTo: constraint,
                                     constant: constant).isActive = true
        }
        else if let superview = superview {
            centerXAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.centerXAnchor,
                                     constant: constant).isActive = true
        }
    }

}

