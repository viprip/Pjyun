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
#include "taskgroup.hpp"


/*! \qmltype TaskGroup
    \instantiates TaskGroup
    \inherits QtObject
    \inqmlmodule Pjyun.Controls.Cards
    \ingroup pjyun_controls_cards
    \since Pjyun.Controls.Cards 1.0

    \brief TaskGroup provides a way to group several tasks.

    A TaskGroup item can contain several \l{Task} items.

    \qml
    import Pjyun.Controls.Cards 1.0

    TaskGroup {
        id: group

        Task {
            title: "Task 01"
            description: "Description of Task 01."
        }

        Task {
            title: "Task 02"
            description: "Description of Task 02."
        }
        // ...
    }
    \endqml
*/

/*! \qmlproperty bool Pjyun.Controls.Cards::TaskGroup::empty
    \readonly

    This read-only property is \c true if the group has tasks.
*/

/*! \qmlproperty int Pjyun.Controls.Cards::TaskGroup::count
    \readonly

    This read-only property holds the current number of tasks in the group.
*/


/*!
  \brief Constructs a TaskGroup object with an optional \a parent as parent.
 */
TaskGroup::TaskGroup(QObject *parent)
    : QObject{parent}
{

}

/*! \qmlproperty list<Task> Pjyun.Controls.Cards::TaskGroup::tasks
    \default

    This default property holds the list of tasks in the group.
*/
QQmlListProperty<Task> TaskGroup::tasks()
{
    return {this, nullptr,
                &TaskGroup::task_append,
                &TaskGroup::task_count,
                &TaskGroup::task_at,
                &TaskGroup::task_clear};
}

/*! \qmlmethod void Pjyun.Controls.Cards::TaskGroup::add(Task task)

    Inserts a \a task at the end of the group.

    \b Note: A task can't be inserted twice in the group.

    \sa insert()
*/
void TaskGroup::add(Task *task)
{
    insert(m_tasks.size(), task);
}

/*! \qmlmethod void Pjyun.Controls.Cards::TaskGroup::insert(int index, Task task)

    Inserts a \a task at index position \a index in the group.

    \b Note: A task can't be inserted twice in the group.

    \sa add()
*/
void TaskGroup::insert(int index, Task *task)
{
    if (!task)
        return;

    int taskIndex = m_tasks.indexOf(task);

    if (taskIndex < 0)
    {
        task->setParent(this);
        m_tasks.insert(index, task);
        emit tasksChanged();
    }
}

/*! \qmlmethod void Pjyun.Controls.Cards::TaskGroup::removeAt(int index)

    Removes the task at index position \a index. \a index must be a valid index position in the
    group (i.e., 0 <= \a index < \l{TaskGroup::count}{count}).

    \sa takeAt()
*/
void TaskGroup::removeAt(int index)
{
    Q_ASSERT_X((0 <= index) && (index < m_tasks.size()), "removeAt", "invalid index: 0 <= index < count");

    auto *task = m_tasks.at(index);

    if (task)
    {
        task->deleteLater();

        m_tasks.removeAt(index);
        emit tasksChanged();
    }
}

/*! \qmlmethod Task Pjyun.Controls.Cards::TaskGroup::takeAt(int index)

    Removes the task at index position \a index and returns it. \a index must be a valid index
    position in the group (i.e., 0 <= \a index < \l{TaskGroup::count}{count}).

    \sa removeAt()
*/
Task *TaskGroup::takeAt(int index)
{
    Q_ASSERT_X((0 <= index) && (index < m_tasks.size()), "takeAt", "invalid index: 0 <= index < count");

    auto *task = m_tasks.takeAt(index);
    emit tasksChanged();

    return task;
}

/*! \qmlmethod Task Pjyun.Controls.Cards::TaskGroup::at(int index)

    Returns the task at the index position \a index. \a index must be a valid index position in the
    group (i.e., 0 <= \a index < \l{TaskGroup::count}{count}).
*/
Task *TaskGroup::at(int index) const
{
    Q_ASSERT_X((0 <= index) && (index < m_tasks.size()), "at", "invalid index: 0 <= index < count");
    return m_tasks.at(index);
}

/*! \qmlmethod void Pjyun.Controls.Cards::TaskGroup::clear()

    Removes all tasks from the group.
*/
void TaskGroup::clear()
{
    for (auto *task : m_tasks)
        task->deleteLater();

    m_tasks.clear();
    emit tasksChanged();
}

void TaskGroup::task_append(QQmlListProperty<Task> *property, Task *task)
{
    auto *taskGroup = qobject_cast<TaskGroup *>(property->object);

    if (taskGroup)
    {
        taskGroup->add(task);
    }
}

Task *TaskGroup::task_at(QQmlListProperty<Task> *property, int index)
{
    const auto *taskGroup = qobject_cast<TaskGroup *>(property->object);

    if (taskGroup)
    {
        return taskGroup->at(index);
    }

    return nullptr;
}

void TaskGroup::task_clear(QQmlListProperty<Task> *property)
{
    auto *taskGroup = qobject_cast<TaskGroup *>(property->object);

    if (taskGroup)
    {
        taskGroup->clear();
    }
}

int TaskGroup::task_count(QQmlListProperty<Task> *property)
{
    const auto *taskGroup = qobject_cast<TaskGroup *>(property->object);

    if (taskGroup)
    {
        return taskGroup->count();
    }

    return 0;
}
