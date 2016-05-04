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
#ifndef PJYUN_CONTROLS_CARDS_TASKGROUP_HPP
#define PJYUN_CONTROLS_CARDS_TASKGROUP_HPP

#include <QObject>
#include <QQmlListProperty>

#include "task.hpp"

class TaskGroup : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QQmlListProperty<Task> tasks READ tasks NOTIFY tasksChanged FINAL)
    Q_PROPERTY(bool empty READ isEmpty FINAL)
    Q_PROPERTY(int count READ count FINAL)
    Q_CLASSINFO("DefaultProperty", "tasks")

public:
    explicit TaskGroup(QObject *parent = nullptr);

    QQmlListProperty<Task> tasks();

    inline bool isEmpty() const;
    inline int count() const;

    Q_INVOKABLE void add(Task *task);
    Q_INVOKABLE void insert(int index, Task *task);
    Q_INVOKABLE void removeAt(int index);
    Q_INVOKABLE Task *takeAt(int index);
    Q_INVOKABLE Task *at(int index) const;
    Q_INVOKABLE void clear();

signals:
    void tasksChanged();

private:
    static void task_append(QQmlListProperty<Task> *property, Task *task);
    static Task *task_at(QQmlListProperty<Task> *property, int index);
    static void task_clear(QQmlListProperty<Task> *property);
    static int task_count(QQmlListProperty<Task> *property);

private:
    Q_DISABLE_COPY(TaskGroup)

    QList<Task *> m_tasks;
};

//--------------------------------------------------------------------------------------------------

inline bool TaskGroup::isEmpty() const
{
    return m_tasks.isEmpty();
}

inline int TaskGroup::count() const
{
    return m_tasks.count();
}

//--------------------------------------------------------------------------------------------------

#endif // PJYUN_CONTROLS_CARDS_TASKGROUP_HPP
