import React, { Component } from 'react';
import { StyleSheet, Text, View } from 'react-native';

import SuperEllipseMask from 'react-native-super-ellipse-mask';

const colors = {
  purple: '#5856D6',
  pink: '#FF2D55',
};

export default class App extends Component {
  state = {
    small: true
  }
  componentDidMount() {
    console.log("componentDidMount")

    setTimeout(() => {
      this.setState({ small: false })
    }, 1000)
    setTimeout(() => {
      this.setState({ small: true })
    }, 2000)
  }

  render() {
    console.log("render")
    return (
      <View style={styles.container}>
        <View style={{ flexDirection: 'row', marginBottom: 20 }}>
          <SuperEllipseMask radius={40} borderWidth={1} borderColor={"red"} style={{ marginRight: 20, width: this.state.small ? 100 : 200, backgroundColor: "blue", height: 160}}>
            <View style={styles.box}>
              <Text style={styles.welcome}>SuperEllipse</Text>
            </View>
          </SuperEllipseMask>
          <View
            style={[
              styles.box,
              { borderRadius: 40, backgroundColor: colors.purple, width: 100 },
            ]}
          >
            <Text style={styles.welcome}>Factory</Text>
          </View>
        </View>
        <View style={{ flexDirection: 'row', marginBottom: 20 }}>
          <SuperEllipseMask
            radius={{
              topRight: 80,
              topLeft: 20,
              bottomRight: 30,
              bottomLeft: 50,
            }}
            style={{ marginRight: 20, backgroundColor: "red" }}
          >
            <View style={styles.box}>
              <Text style={styles.welcome}>SuperEllipse</Text>
            </View>
          </SuperEllipseMask>
          <View
            style={[
              styles.box,
              {
                borderBottomRightRadius: 30,
                borderBottomLeftRadius: 50,
                borderTopRightRadius: 80,
                borderTopLeftRadius: 20,
                backgroundColor: colors.purple,
              },
            ]}
          >
            <Text style={styles.welcome}>Factory</Text>
          </View>
        </View>
        <View style={{ flexDirection: 'row', marginBottom: 20 }}>
          <SuperEllipseMask radius={62} style={{ marginRight: 20 }}>
            <View style={styles.box}>
              <Text style={styles.welcome}>SuperEllipse</Text>
            </View>
          </SuperEllipseMask>
          <View
            style={[
              styles.box,
              {
                borderRadius: 300,
                backgroundColor: colors.purple,
              },
            ]}
          >
            <Text style={styles.welcome}>Factory</Text>
          </View>
        </View>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  box: {
    justifyContent: 'center',
    alignItems: 'center',
    width: 160,
    height: 160,
  },
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#FFF',
  },
  welcome: {
    fontSize: 18,
    textAlign: 'center',
    color: 'black',
  },
});
