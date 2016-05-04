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
import QtTest 1.1
import Pjyun.Controls.Cards 1.0

TestCase {
    id: testCase
    name: "TaskController"

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Child Objects                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    Component {
        id: taskControllerItem
        TaskController {}
    }

    Component {
        id: taskItem
        Task {}
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Signals Spies                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    SignalSpy {
        id: conditionSignalSpy
        signalName: "conditionChanged"
    }

    SignalSpy {
        id: completedSignalSpy
        signalName: "completed"
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Tests                                                                                     //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    function init() {
        verify(!conditionSignalSpy.target)
        compare(conditionSignalSpy.count, 0)
    }

    function cleanup() {
        conditionSignalSpy.target = null
        conditionSignalSpy.clear()
    }

    function test_property_condition() {
        var taskController = taskControllerItem.createObject(testCase)
        verify(taskControllerItem)

        var task01 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task01)
        var task02 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task02)
        var task03 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task03)
        var task04 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task04)
        var task05 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task05)

        conditionSignalSpy.target = taskController
        verify(conditionSignalSpy.valid)

        compare(taskController.condition, false)
        compare(conditionSignalSpy.count, 0)

        task01.completed = true
        compare(taskController.condition, false)
        compare(conditionSignalSpy.count, 1)

        task02.completed = true
        compare(taskController.condition, false)
        compare(conditionSignalSpy.count, 2)

        task03.completed = true
        compare(taskController.condition, false)
        compare(conditionSignalSpy.count, 3)

        task04.completed = true
        compare(taskController.condition, false)
        compare(conditionSignalSpy.count, 4)

        task05.completed = true
        compare(taskController.condition, true)
        compare(conditionSignalSpy.count, 5)

        // task03 is no longer completed
        task03.completed = false
        compare(taskController.condition, false)
        compare(conditionSignalSpy.count, 6)

        task03.completed = true
        compare(taskController.condition, true)
        compare(conditionSignalSpy.count, 7)

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskController.destroy()
    }

    function test_signal_completed() {
        var taskController = taskControllerItem.createObject(testCase)
        verify(taskController)

        var task01 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task01)
        var task02 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task02)
        var task03 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task03)
        var task04 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task04)
        var task05 = taskItem.createObject(testCase, { "controller": taskController })
        verify(task05)

        completedSignalSpy.target = taskController
        verify(completedSignalSpy.valid)

        task01.completed = true
        compare(completedSignalSpy.count, 0)

        task02.completed = true
        compare(completedSignalSpy.count, 0)

        task03.completed = true
        compare(completedSignalSpy.count, 0)

        task04.completed = true
        compare(completedSignalSpy.count, 0)

        task05.completed = true
        compare(completedSignalSpy.count, 1)

        // task01 has switched its state
        task01.completed = false
        compare(completedSignalSpy.count, 1)

        task01.completed = true
        compare(completedSignalSpy.count, 2)

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskController.destroy()
    }
}
