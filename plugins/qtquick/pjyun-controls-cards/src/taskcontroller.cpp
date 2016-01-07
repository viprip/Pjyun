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
#include "taskcontroller.hpp"

#include "task.hpp"


/*! \qmltype TaskController
    \instantiates TaskController
    \inherits QtObject
    \inqmlmodule Pjyun.Controls.Cards
    \ingroup pjyun_controls_cards
    \since Pjyun.Controls.Cards 1.0

    \brief Evaluates the condition of several tasks.

    A TaskController item is useful when you want to evaluate the condition of several tasks.

    \qml
    import Pjyun.Controls.Cards 1.0

    Item {

        // ...

        TaskController {
            id: taskController

            onCompleted: console.log("Task01 and Task02 are completed their condition.")
        }

        Task {
            id: task01
            controller: taskController
        }

        Task {
            id: task02
            controller: taskController
        }

        // ...
    }
    \endqml

    In the example above, when \c task01 and \c task02 will have set their
    \l{Task::completed}{completed} property to \c true, then the \c taskController will emit the
    \l{TaskController::completed}{completed()} signal.
*/

/*! \qmlproperty bool Pjyun.Controls.Cards::TaskController::condition
    \readonly

    This read-only property holds the current state of the tasks handled by the controller.

    \sa completed
*/

/*! \qmlsignal void Pjyun.Controls.Cards::TaskController::completed()

    This signal is emitted when all of the tasks handled by the controller are met their condition.

    The corresponding handler is \c onCompleted.
*/


/*!
  \brief Constructs a TaskController object with an optional \a parent as parent.
*/
TaskController::TaskController(QObject *parent)
    : QObject{parent}
{
}

/*! \internal */
void TaskController::addTask(Task *task)
{
    if (!task)
        return;

    QObject::connect(task, &Task::completedChanged, this, &TaskController::evaluate);
    m_tasks.push_back(task);
}

/*! \internal */
void TaskController::removeTask(Task *task)
{
    if (!task)
        return;

    if (m_tasks.removeOne(task))
    {
        task->disconnect(this);
        evaluate();
    }
}

void TaskController::evaluate()
{
    m_tasks.removeAll(nullptr);
    m_condition = true;

    for (const auto task : m_tasks)
    {
        if (!task->isCompleted())
        {
            m_condition = false;
            break;
        }
    }

    if (m_condition)
        emit completed();

    emit conditionChanged();
}
