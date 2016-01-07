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
//            but WITHOUT ANY WARRANTY without even the implied warranty of                       //
//            MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                       //
//            GNU General Public License for more details.                                        //
//                                                                                                //
//            You should have received a copy of the GNU General Public License                   //
//            along with this program.  If not, see <http://www.gnu.org/licenses/>.               //
//                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////
import QtQuick 2.5
import QtTest 1.1
import Pjyun.Controls.Cards 1.0

TestCase {
    id: testCase
    name: "Task"

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Child objects                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    Component {
        id: taskItem
        Task {}
    }

    Component {
        id: taskControllerItem
        TaskController {}
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Signals Spies                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    SignalSpy {
        id: titleSignalSpy
        signalName: "titleChanged"
    }

    SignalSpy {
        id: descriptionSignalSpy
        signalName: "descriptionChanged"
    }

    SignalSpy {
        id: completedSignalSpy
        signalName: "completedChanged"
    }

    SignalSpy {
        id: controllerSignalSpy
        signalName: "controllerChanged"
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Tests                                                                                     //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    function init() {
        verify(!titleSignalSpy.target)
        compare(titleSignalSpy.count, 0)

        verify(!descriptionSignalSpy.target)
        compare(descriptionSignalSpy.count, 0)

        verify(!completedSignalSpy.target)
        compare(completedSignalSpy.count, 0)

        verify(!controllerSignalSpy.target)
        compare(controllerSignalSpy.count, 0)
    }

    function cleanup() {
        titleSignalSpy.target = null
        titleSignalSpy.clear()

        descriptionSignalSpy.target = null
        descriptionSignalSpy.clear()

        completedSignalSpy.target = null
        completedSignalSpy.clear()

        controllerSignalSpy.target = null
        controllerSignalSpy.clear()
    }

    function test_property_title() {
        var task = taskItem.createObject(testCase)
        verify(task)

        titleSignalSpy.target = task
        verify(titleSignalSpy.valid)

        compare(task.title, "")
        compare(titleSignalSpy.count, 0)

        task.title = "Task 01"
        compare(task.title, "Task 01")
        compare(titleSignalSpy.count, 1)

        task.title = ""
        compare(task.title, "")
        compare(titleSignalSpy.count, 2)

        task.destroy()
    }

    function test_property_description() {
        var task = taskItem.createObject(testCase)
        verify(task)

        descriptionSignalSpy.target = task
        verify(descriptionSignalSpy.valid)

        compare(task.description, "")
        compare(descriptionSignalSpy.count, 0)

        task.description = "Description of Task 01"
        compare(task.description, "Description of Task 01")
        compare(descriptionSignalSpy.count, 1)

        task.description = ""
        compare(task.description, "")
        compare(descriptionSignalSpy.count, 2)

        task.destroy()
    }

    function test_property_completed() {
        var task = taskItem.createObject(testCase)
        verify(task)

        completedSignalSpy.target = task
        verify(completedSignalSpy.valid)

        compare(task.completed, false)
        compare(completedSignalSpy.count, 0)

        task.completed = true
        compare(task.completed, true)
        compare(completedSignalSpy.count, 1)

        task.completed = false
        compare(task.completed, false)
        compare(completedSignalSpy.count, 2)

        task.destroy()
    }

    function test_property_controller() {
        var task = taskItem.createObject(testCase)
        verify(task)

        var controller = taskControllerItem.createObject(testCase)
        verify(controller)

        controllerSignalSpy.target = task
        verify(controllerSignalSpy.valid)

        compare(task.controller, null)
        compare(controllerSignalSpy.count, 0)

        task.controller = controller
        compare(task.controller, controller)
        compare(controllerSignalSpy.count, 1)

        task.controller = null
        compare(task.controller, null)
        compare(controllerSignalSpy.count, 2)

        controller.destroy()
        task.destroy()
    }
}
