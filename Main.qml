import QtQuick
import QtSensors

Window {
    id: mainWindow
    width: 320
    height: 480
    visible: true
    title: qsTr("42Hangouts")
    readonly property double radians_to_degrees: 180 / Math.PI
    
    Gyroscope {
        id: gyro
        active: true
        dataRate: 100  // Set an appropriate data rate

        Component.onCompleted: {
            console.log("Gyroscope has been created and is active.");
        }

        onReadingChanged: {
            if (gyro.reading) {
                console.log("Gyroscope Reading: x =", gyro.reading.x, "y =", gyro.reading.y, "z =", gyro.reading.z);
            } else {
                console.log("No valid gyroscope reading.");
            }
        }
    }

    Accelerometer {
        id: accel
        active: true
        dataRate: 100

        Component.onCompleted: {
            console.log("Accelerometer has been created and is active.");
        }

        onReadingChanged: {
            if (gyro.reading) {
                console.log("Accelerometer Reading: x =", gyro.reading.x, "y =", gyro.reading.y, "z =", gyro.reading.z);
            } else {
                console.log("No valid gyroscope reading.");
            }
        }
    }

    function calcPitch(x,y,z) {
        return -Math.atan2(y, Math.hypot(x, z)) * mainWindow.radians_to_degrees;
    }

    function calcRoll(x,y,z) {
        return -Math.atan2(x, Math.hypot(y, z)) * mainWindow.radians_to_degrees;
    }

    Image {
        id: bubble
        source: "42_Logo.png"
        smooth: true
        width: 100
        height: 100
        property real centerX: mainWindow.width / 2
        property real centerY: mainWindow.height / 2
        property real bubbleCenter: bubble.width / 2
        x: centerX - bubbleCenter
        y: centerY - bubbleCenter

        // Add animation for smooth movement, if you want the bubble to move later
        Behavior on x {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 100
            }
        }
        Behavior on y {
            SmoothedAnimation {
                easing.type: Easing.Linear
                duration: 100
            }
        }
    }
}
