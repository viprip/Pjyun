////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//            Copyright (C) 2015-2016 William McKIE                                               //
//                                                                                                //
//            This program is free software: you can redistribute it and/or modify                //
//            it under the terms of the GNU General Public License as published by                //
//            the Free Software Foundation, either version 3 of the License, or                   //
//            (at your option) any later version.                                                 //
//                                                                                                //
//            This program is distributed in the hope that it will be useful,                     //
//            but WITHOUT ANY WARRANTY; without even the implied warranty of                      //
//            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                       //
//            GNU General Public License for more details.                                        //
//                                                                                                //
//            You should have received a copy of the GNU General Public License                   //
//            along with this program.  If not, see <http://www.gnu.org/licenses/>.               //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////
import QtQuick 2.5
import QtQuick.Controls 1.4
import Stoiridh.Settings 1.0

ApplicationWindow {
    id: mainWindow
    title: "Pjyun"
    minimumWidth: 800
    minimumHeight: 600
    visible: true

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Object properties                                                                         //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    menuBar: MenuBar {
        Menu {
            title: qsTr("&File")

            Menu {
                title: qsTr("&New")

                MenuItem {
                    text: qsTr("&Project")
                    shortcut: StandardKey.New
                }
            }

            MenuItem {
                text: qsTr("E&xit")
                shortcut: StandardKey.Quit

                onTriggered: {
                    SettingManager.save()
                    Qt.quit()
                }
            }
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Events                                                                                    //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    onClosing: SettingManager.save()
    Component.onCompleted: SettingManager.load()

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Child objects                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    MainForm {
        anchors.fill: parent
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Settings                                                                                  //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    GroupSettings {
        name: "MainWindow"

        WindowSetting { window: mainWindow }
    }
}
