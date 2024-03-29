/*
    Copyright 2014-2015 Harald Sitter <sitter@kde.org>

    This program is free software; you can redistribute it and/or
    modify it under the terms of the GNU General Public License as
    published by the Free Software Foundation; either version 2 of
    the License or (at your option) version 3 or any later version
    accepted by the membership of KDE e.V. (or its successor approved
    by the membership of KDE e.V.), which shall act as a proxy
    defined in Section 14 of version 3 of the license.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.0
import QtQuick.Controls 1.0
import QtQuick.Layouts 1.0

import org.kde.kquickcontrolsaddons 2.0

ColumnLayout {
    id: delegate
    width: parent.width

    RowLayout {
        QIconItem {
            id: clientIcon
            Layout.alignment: Qt.AlignHCenter
            width: height
            height: nameLabel.contentHeight
            icon: PulseObject.properties['device.icon_name'] ? PulseObject.properties['device.icon_name'] : 'audio-card'
        }

        Label {
            id: nameLabel
            Layout.fillWidth: true
            text: PulseObject.properties['device.description'] ? PulseObject.properties['device.description'] : PulseObject.name
            elide: "ElideRight"
        }
    }

    RowLayout {
        Label {
            id: profileLabel
            text: i18nc("@label", "Profile:")
            font.bold: true
        }
        ComboBox {
            Layout.fillWidth: true
            model: PulseObject.profiles
            // NOTE: model resets (i.e. profiles property changes) will reset
            // the currentIndex, so force it to be set on model changes, otherwise
            // it would eventually become 0 when it shouldn't be.
            onModelChanged: currentIndex = PulseObject.activeProfileIndex
            textRole: "description"
            currentIndex: PulseObject.activeProfileIndex
            onActivated: PulseObject.activeProfileIndex = index
        }
    }

    ListItemSeperator { view: delegate.ListView.view }
}
