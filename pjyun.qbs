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
import qbs 1.0
import qbs.FileInfo

Project {
    name: "Pjyun"
    minimumQbsVersion: '1.4.0'
    qbsSearchPaths: ['qbs']

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Properties                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    readonly property string productName: "pjyun"

    readonly property path binaryDirectory: 'bin'
    readonly property path librariesDirectory: FileInfo.joinPaths('lib')
    readonly property path pluginsDirectory: FileInfo.joinPaths(librariesDirectory, productName,
                                                                'plugins')
    readonly property path qmlDirectory: FileInfo.joinPaths(librariesDirectory, productName, 'qml')
    readonly property path shareDirectory: FileInfo.joinPaths('share', productName)
    readonly property path docDirectory: FileInfo.joinPaths('share', 'doc', productName)

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  References                                                                                //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    references: [
        "apps",
        "plugins",
        "tests"
    ]
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  AutotestRunner                                                                            //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    AutotestRunner {
        arguments: {
            var args = [];
            args.push('-import');
            args.push(FileInfo.joinPaths(qbs.installRoot, project.qmlDirectory));
            return args;
        }
    }
}
