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
    const { radius, backgroundColor, borderColor, borderWidth, ...rest } = this.props;

    wrappedStyle = {};
    if (borderColor) {
      wrappedStyle.brdColor = processColor(borderColor);
    }
    if (borderWidth) {
      wrappedStyle.brdWidth = borderWidth;
    }

    let r = {
      topLeft: radius,
      topRight: radius,
      bottomLeft: radius,
      bottomRight: radius,
    };
    if (typeof radius == 'object') {
      r = radius;
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