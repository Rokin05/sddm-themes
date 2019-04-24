/*
 *   Copyright 2019 Romain V. <contact@rokin.in> - <https://github.com/Rokin05>
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU Library General Public
 *   License along with this program; if not, see <https://www.gnu.org/licenses>.
 */

import QtQuick 2.8
import QtQuick.Layouts 1.3
import QtGraphicalEffects 1.0

Item {
    readonly property bool softwareRendering: GraphicsInfo.api === GraphicsInfo.Software

    property date dateTime: new Date()
    width: (daynum.width + month.width) <= day.width ? day.width : (daynum.width + month.width)
    height: day.height + daynum.height
    anchors.topMargin: 12

    //Rectangle {anchors.fill: parent; color: "red"; opacity: 0.1} //DEBUG

    Timer {
        id: timer
        interval: 1000; running: true; repeat: true;
        onTriggered: clock.dateTime = new Date()
    }

    Text {
        id: day
        text : Qt.formatDate(clock.dateTime, "dddd")
        color: conf("date.color")
        font.pointSize: 62
        font.letterSpacing: 12
        font.italic: conf("date.italic")
        font.bold: conf("date.bold")
        visible: conf("date.visible")
        font.capitalization: Font.AllUppercase
        Component.onCompleted: if (conf("date.font") != "") font.family = conf("date.font")
    }

    Text {
        id: daynum
        anchors.top: day.bottom
        anchors.topMargin: -26
        text : Qt.formatDate(clock.dateTime, "dd")
        color: "#c5c2c4"
        font.pointSize: 82
        font.italic: conf("date.italic")
        font.bold: conf("date.bold")
        visible: conf("date.visible")
        font.capitalization: Font.AllUppercase
        Component.onCompleted: if (conf("date.font") != "") font.family = conf("date.font")
    }

    Text {
        id: month
        anchors.top: day.bottom
        anchors.left: daynum.right
        anchors.topMargin: -14
        text : Qt.formatDate(clock.dateTime, " MMMM yyyy")
        color: "#c5c2c4"
        font.pointSize: conf("date.size")
        font.italic: conf("date.italic")
        font.bold: conf("date.bold")
        visible: conf("date.visible")
        font.capitalization: Font.AllUppercase
        Component.onCompleted: if (conf("date.font") != "") font.family = conf("date.font")
    }

    Text {
        id: time
        anchors.top: month.bottom
        anchors.left: daynum.right
        anchors.topMargin: -10
        text : Qt.formatTime(clock.dateTime, conf("time.format"))
        color: conf("time.color")
        font.pointSize: conf("time.size")
        font.italic: conf("time.italic")
        font.bold: conf("time.bold")
        visible: conf("time.visible")
        Component.onCompleted: if (conf("time.font") != "") font.family = conf("time.font")
    }


    // Shadow
    layer.enabled: !softwareRendering
    layer.effect: DropShadow {
        horizontalOffset: 0
        verticalOffset: 2
        radius: conf("shadow.radius")
        samples: 32
        spread: conf("shadow.spread")
        color: conf("shadow.color")
    }

    // Conf
    function conf(key, section) {
        var sec = (section === undefined ? "clock" : section);
        var val = config[sec + "/" + key];
        if (val === "true") {return true;}
        if (val === "false") {return false;}
        return val;
    }
}