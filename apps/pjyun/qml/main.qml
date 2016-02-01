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

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Object properties                                                                         //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    title: "Pjyun"
    minimumWidth: 800; minimumHeight: 600
    visible: true

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Child objects                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    MainForm {
        anchors.fill: parent
    }

    GroupSettings {
        name: "Application"

        WindowSettings {
            name: "MainWindow"
            x: 120; y: 120; width: 800; height: 600
            preferredPosition: WindowSettings.Centred
            window: mainWindow
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Events                                                                                    //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    onClosing: SettingsManager.save()
    Component.onCompleted: SettingsManager.load()
}
