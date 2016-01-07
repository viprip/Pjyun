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
#include "task.hpp"

#include "taskcontroller.hpp"


/*! \qmltype Task
    \instantiates Task
    \inherits QtObject
    \inqmlmodule Pjyun.Controls.Cards
    \ingroup pjyun_controls_cards
    \since Pjyun.Controls.Cards 1.0

    \brief Represents a task holding a title and a description.

    A Task item holds a title and a description describing the task role.

    \qml
    import Pjyun.Controls.Cards 1.0

    Task {
        id: task01
        title: "Task 01"
        description: "Description of Task 01."
    }
    \endqml
*/


/*!
  \brief Constructs a Task object with an optional \a parent as parent.
*/
Task::Task(QObject *parent)
    : QObject{parent}
{

}

/*!
  \brief Destroys a Task object.
*/
Task::~Task()
{
    if (m_controller)
        disconnect(m_controller);
}

/*! \qmlproperty string Pjyun.Controls.Cards::Task::title

    This property holds the title of the task.
*/
void Task::setTitle(QString title)
{
    if (m_title != title)
    {
        m_title = title;
        emit titleChanged();
    }
}

/*! \qmlproperty string Pjyun.Controls.Cards::Task::description

    This property holds the description of the task.
*/
void Task::setDescription(QString description)
{
    if (m_description != description)
    {
        m_description = description;
        emit descriptionChanged();
    }
}

/*! \qmlproperty bool Pjyun.Controls.Cards::Task::completed

    This property holds the condition required to complete a task.
*/
void Task::setCompleted(bool completed)
{
    if (m_completed != completed)
    {
        m_completed = completed;
        emit completedChanged();
    }
}

TaskController *Task::controller() const
{
    return m_controller.data();
}

/*! \qmlproperty TaskController Pjyun.Controls.Cards::Task::controller

    This property holds a controller to be submit to an evaluation.
*/
void Task::setController(TaskController *controller)
{
    if (m_controller != controller)
    {
        if (m_controller)
            m_controller->removeTask(this);

        m_controller = controller;

        if (m_controller)
            m_controller->addTask(this);

        emit controllerChanged();
    }
}
