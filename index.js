// import { NativeModules } from 'react-native';

// const { RNSuperEllipseMask } = NativeModules;

// export default RNSuperEllipseMask;

import React, { Component } from 'react';
import PropTypes from 'prop-types';
import { requireNativeComponent, processColor } from 'react-native';

const SuperEllipseMask = requireNativeComponent(
  'SuperEllipseMask',
  SuperEllipseMaskView
);

export default class SuperEllipseMaskView extends Component {
  render() {
    const { smoothBorderRadius, smoothBorderColor, smoothBorderWidth, smoothBackgroundColor, ...rest } = this.props;

    wrappedStyle = {};
    if (smoothBorderColor) {
      wrappedStyle.brdColor = processColor(smoothBorderColor);
    }
    if (smoothBorderWidth) {
      wrappedStyle.brdWidth = smoothBorderWidth;
    }
    if (smoothBackgroundColor) {
      wrappedStyle.bckColor = processColor(smoothBackgroundColor);
    }

    let r = {
      topLeft: smoothBorderRadius,
      topRight: smoothBorderRadius,
      bottomLeft: smoothBorderRadius,
      bottomRight: smoothBorderRadius,
    };
    if (typeof smoothBorderRadius == 'object') {
      r = smoothBorderRadius;
    }

    return <SuperEllipseMask {...rest} {...wrappedStyle} {...r} />;
  }
}

SuperEllipseMaskView.propTypes = {
  topLeft: PropTypes.number,
  topRight: PropTypes.number,
  bottomRight: PropTypes.number,
  bottomLeft: PropTypes.number,
};