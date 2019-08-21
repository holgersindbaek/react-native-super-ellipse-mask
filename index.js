// import { NativeModules } from 'react-native';

// const { RNSuperEllipseMask } = NativeModules;

// export default RNSuperEllipseMask;

import React, { Component } from 'react';
import { requireNativeComponent, processColor } from 'react-native';

const SuperEllipseMask = requireNativeComponent(
  'SuperEllipseMask',
  SuperEllipseMaskView
);

export default class SuperEllipseMaskView extends Component {
  render() {
    const { style, ...rest } = this.props;

    wrappedStyle = {};
    // manipulate style
    if (style && style.backgroundColor) {
      wrappedStyle.bckColor = processColor(style.backgroundColor);
    }
    if (style && style.borderColor) {
      wrappedStyle.brdColor = processColor(style.borderColor);
    }
    if (style && style.borderWidth) {
      wrappedStyle.brdWidth = style.borderWidth;
    }

    // border radii
    if (style && style.borderRadius) {
      wrappedStyle.brdRadius = style.borderRadius;
    }

    const {
      borderRadius,
      backgroundColor,
      borderColor,
      borderWidth,
      ...reducedStyle
    } = style;

    return <SuperEllipseMask {...rest} {...wrappedStyle} {...reducedStyle} />;
  }
}
