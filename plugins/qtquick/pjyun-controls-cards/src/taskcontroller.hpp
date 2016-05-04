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
#ifndef PJYUN_CONTROLS_CARDS_TASKCONTROLLER_HPP
#define PJYUN_CONTROLS_CARDS_TASKCONTROLLER_HPP

#include <QObject>
#include <QPointer>
#include <QVector>

class Task;

class TaskController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool condition READ condition NOTIFY conditionChanged)

public:
    explicit TaskController(QObject *parent = nullptr);

    inline bool condition() const;

    void addTask(Task *task);
    void removeTask(Task *task);

signals:
    void conditionChanged();
    void completed();

private slots:
    void evaluate();

private:
    Q_DISABLE_COPY(TaskController)

    QVector<QPointer<Task>> m_tasks;
    bool m_condition{false};
};

//--------------------------------------------------------------------------------------------------

inline bool TaskController::condition() const
{
    return m_condition;
}

//--------------------------------------------------------------------------------------------------

#endif // PJYUN_CONTROLS_CARDS_TASKCONTROLLER_HPP
