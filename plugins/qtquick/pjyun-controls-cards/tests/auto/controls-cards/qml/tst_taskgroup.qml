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
    name: "TaskGroup"

    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Child Objects                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    Component {
        id: taskGroupItem
        TaskGroup {}
    }

    Component {
        id: taskItem
        Task {}
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Signals Spies                                                                             //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    SignalSpy {
        id: tasksSignalSpy
        signalName: "tasksChanged"
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////
    //  Tests                                                                                     //
    ////////////////////////////////////////////////////////////////////////////////////////////////
    function init() {
        verify(!tasksSignalSpy.target)
        compare(tasksSignalSpy.count, 0)
    }

    function cleanup() {
        tasksSignalSpy.target = null
        tasksSignalSpy.clear()
    }

    function test_property_empty() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)
        verify(taskGroup.empty)

        var task01 = taskItem.createObject(testCase)
        verify(task01)

        taskGroup.add(task01)
        verify(!taskGroup.empty)

        taskGroup.removeAt(0)
        verify(taskGroup.empty)

        task01.destroy()
        taskGroup.destroy()
    }

    function test_property_count() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)

        var task01 = taskItem.createObject(testCase)
        verify(task01)
        var task02 = taskItem.createObject(testCase)
        verify(task02)
        var task03 = taskItem.createObject(testCase)
        verify(task03)
        var task04 = taskItem.createObject(testCase)
        verify(task04)
        var task05 = taskItem.createObject(testCase)
        verify(task05)

        compare(taskGroup.count, 0)

        taskGroup.add(task01)
        compare(taskGroup.count, 1)
        taskGroup.add(task02)
        compare(taskGroup.count, 2)
        taskGroup.add(task03)
        compare(taskGroup.count, 3)
        taskGroup.add(task04)
        compare(taskGroup.count, 4)
        taskGroup.add(task05)
        compare(taskGroup.count, 5)

        // re-append the tasks previously added into the same group
        // to check there are no duplicate tasks.
        taskGroup.add(task01)
        compare(taskGroup.count, 5)
        taskGroup.add(task02)
        compare(taskGroup.count, 5)
        taskGroup.add(task03)
        compare(taskGroup.count, 5)
        taskGroup.add(task04)
        compare(taskGroup.count, 5)
        taskGroup.add(task05)
        compare(taskGroup.count, 5)

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskGroup.destroy()
    }

    function test_method_add() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)
        verify(taskGroup.empty)

        var task01 = taskItem.createObject(testCase)
        verify(task01)
        var task02 = taskItem.createObject(testCase)
        verify(task02)
        var task03 = taskItem.createObject(testCase)
        verify(task03)
        var task04 = taskItem.createObject(testCase)
        verify(task04)
        var task05 = taskItem.createObject(testCase)
        verify(task05)

        tasksSignalSpy.target = taskGroup
        verify(tasksSignalSpy.valid)

        taskGroup.add(task01)
        compare(task01, taskGroup.at(0))
        compare(tasksSignalSpy.count, 1)

        taskGroup.add(task02)
        compare(task02, taskGroup.at(1))
        compare(tasksSignalSpy.count, 2)

        taskGroup.add(task03)
        compare(task03, taskGroup.at(2))
        compare(tasksSignalSpy.count, 3)

        taskGroup.add(task04)
        compare(task04, taskGroup.at(3))
        compare(tasksSignalSpy.count, 4)

        taskGroup.add(task05)
        compare(task05, taskGroup.at(4))
        compare(tasksSignalSpy.count, 5)

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskGroup.destroy()
    }

    function test_method_insert() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)
        verify(taskGroup.empty)

        var task01 = taskItem.createObject(testCase)
        verify(task01)
        var task02 = taskItem.createObject(testCase)
        verify(task02)
        var task03 = taskItem.createObject(testCase)
        verify(task03)
        var task04 = taskItem.createObject(testCase)
        verify(task04)
        var task05 = taskItem.createObject(testCase)
        verify(task05)

        tasksSignalSpy.target = taskGroup
        verify(tasksSignalSpy.valid)

        taskGroup.insert(0, task01)
        compare(tasksSignalSpy.count, 1)

        taskGroup.insert(1, task02)
        compare(tasksSignalSpy.count, 2)

        taskGroup.insert(0, task03)
        compare(tasksSignalSpy.count, 3)

        taskGroup.insert(73, task04)
        compare(tasksSignalSpy.count, 4)

        taskGroup.insert(2, task05)
        compare(tasksSignalSpy.count, 5)

        // compare orders: task03, task01, task05, task02, task04
        compare(task03, taskGroup.at(0))
        compare(task01, taskGroup.at(1))
        compare(task05, taskGroup.at(2))
        compare(task02, taskGroup.at(3))
        compare(task04, taskGroup.at(4))

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskGroup.destroy()
    }

    function test_method_removeAt() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)
        verify(taskGroup.empty)

        var task01 = taskItem.createObject(testCase)
        verify(task01)
        var task02 = taskItem.createObject(testCase)
        verify(task02)
        var task03 = taskItem.createObject(testCase)
        verify(task03)
        var task04 = taskItem.createObject(testCase)
        verify(task04)
        var task05 = taskItem.createObject(testCase)
        verify(task05)

        tasksSignalSpy.target = taskGroup
        verify(tasksSignalSpy.valid)

        taskGroup.add(task01)
        taskGroup.add(task02)
        taskGroup.add(task03)
        taskGroup.add(task04)
        taskGroup.add(task05)
        compare(taskGroup.count, 5)
        compare(tasksSignalSpy.count, 5)

        // remove task01
        taskGroup.removeAt(0)
        compare(taskGroup.count, 4)
        compare(tasksSignalSpy.count, 6)

        // remove task03
        taskGroup.removeAt(1)
        compare(taskGroup.count, 3)
        compare(tasksSignalSpy.count, 7)

        // remove task02
        taskGroup.removeAt(0)
        compare(taskGroup.count, 2)
        compare(tasksSignalSpy.count, 8)

        // remove task05
        taskGroup.removeAt(1)
        compare(taskGroup.count, 1)
        compare(tasksSignalSpy.count, 9)

        // remove task04
        taskGroup.removeAt(0)
        compare(taskGroup.count, 0)
        compare(tasksSignalSpy.count, 10)

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskGroup.destroy()
    }

    function test_method_takeAt() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)
        verify(taskGroup.empty)

        var task01 = taskItem.createObject(testCase)
        verify(task01)
        var task02 = taskItem.createObject(testCase)
        verify(task02)
        var task03 = taskItem.createObject(testCase)
        verify(task03)
        var task04 = taskItem.createObject(testCase)
        verify(task04)
        var task05 = taskItem.createObject(testCase)
        verify(task05)

        tasksSignalSpy.target = taskGroup
        verify(tasksSignalSpy.valid)

        taskGroup.add(task01)
        taskGroup.add(task02)
        taskGroup.add(task03)
        taskGroup.add(task04)
        taskGroup.add(task05)
        compare(taskGroup.count, 5)
        compare(tasksSignalSpy.count, 5)

        // take task01
        var t = taskGroup.takeAt(0)
        compare(t, task01)
        compare(taskGroup.count, 4)
        compare(tasksSignalSpy.count, 6)

        // take task04
        t = taskGroup.takeAt(2)
        compare(t, task04)
        compare(taskGroup.count, 3)
        compare(tasksSignalSpy.count, 7)

        // take task05
        t = taskGroup.takeAt(2)
        compare(t, task05)
        compare(taskGroup.count, 2)
        compare(tasksSignalSpy.count, 8)

        // take task03
        t = taskGroup.takeAt(1)
        compare(t, task03)
        compare(taskGroup.count, 1)
        compare(tasksSignalSpy.count, 9)

        // take task02
        t = taskGroup.takeAt(0)
        compare(t, task02)
        compare(taskGroup.count, 0)
        compare(tasksSignalSpy.count, 10)

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskGroup.destroy()
    }

    function test_method_at() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)
        verify(taskGroup.empty)

        var task01 = taskItem.createObject(testCase)
        verify(task01)
        var task02 = taskItem.createObject(testCase)
        verify(task02)
        var task03 = taskItem.createObject(testCase)
        verify(task03)
        var task04 = taskItem.createObject(testCase)
        verify(task04)
        var task05 = taskItem.createObject(testCase)
        verify(task05)

        taskGroup.add(task05)
        taskGroup.add(task02)
        taskGroup.insert(1, task01)
        taskGroup.insert(0, task03)
        taskGroup.add(task04)

        // compare orders: task03, task05, task01, task02, task04
        compare(task03, taskGroup.at(0))
        compare(task05, taskGroup.at(1))
        compare(task01, taskGroup.at(2))
        compare(task02, taskGroup.at(3))
        compare(task04, taskGroup.at(4))

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskGroup.destroy()
    }

    function test_method_clear() {
        var taskGroup = taskGroupItem.createObject(testCase)
        verify(taskGroup)
        verify(taskGroup.empty)

        var task01 = taskItem.createObject(testCase)
        verify(task01)
        var task02 = taskItem.createObject(testCase)
        verify(task02)
        var task03 = taskItem.createObject(testCase)
        verify(task03)
        var task04 = taskItem.createObject(testCase)
        verify(task04)
        var task05 = taskItem.createObject(testCase)
        verify(task05)

        tasksSignalSpy.target = taskGroup
        verify(tasksSignalSpy.valid)

        taskGroup.add(task01)
        compare(taskGroup.count, 1)
        compare(tasksSignalSpy.count, 1)

        taskGroup.add(task02)
        compare(taskGroup.count, 2)
        compare(tasksSignalSpy.count, 2)

        taskGroup.add(task03)
        compare(taskGroup.count, 3)
        compare(tasksSignalSpy.count, 3)

        taskGroup.add(task04)
        compare(taskGroup.count, 4)
        compare(tasksSignalSpy.count, 4)

        taskGroup.add(task05)
        compare(taskGroup.count, 5)
        compare(tasksSignalSpy.count, 5)

        taskGroup.clear()
        compare(taskGroup.count, 0)
        compare(tasksSignalSpy.count, 6)

        task05.destroy()
        task04.destroy()
        task03.destroy()
        task02.destroy()
        task01.destroy()
        taskGroup.destroy()
    }
}
