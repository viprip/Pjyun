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
#ifndef PJYUN_CONTROLS_CARDS_TASK_HPP
#define PJYUN_CONTROLS_CARDS_TASK_HPP

#include <QObject>
#include <QPointer>

class TaskController;

class Task : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString title READ title WRITE setTitle NOTIFY titleChanged FINAL)
    Q_PROPERTY(QString description READ description WRITE setDescription NOTIFY descriptionChanged FINAL)
    Q_PROPERTY(bool completed READ isCompleted WRITE setCompleted NOTIFY completedChanged FINAL)
    Q_PROPERTY(TaskController* controller READ controller WRITE setController NOTIFY controllerChanged FINAL)

public:
    explicit Task(QObject *parent = nullptr);
    ~Task();

    inline QString title() const;
    void setTitle(QString title);

    inline QString description() const;
    void setDescription(QString description);

    inline bool isCompleted() const;
    void setCompleted(bool completed);

    TaskController *controller() const;
    void setController(TaskController *controller);

signals:
    void titleChanged();
    void descriptionChanged();
    void completedChanged();
    void controllerChanged();

private:
    Q_DISABLE_COPY(Task)

    QString m_title;
    QString m_description;
    bool m_completed{false};
    QPointer<TaskController> m_controller;
};

//--------------------------------------------------------------------------------------------------

inline QString Task::title() const
{
    return m_title;
}

inline QString Task::description() const
{
    return m_description;
}

inline bool Task::isCompleted() const
{
    return m_completed;
}

//--------------------------------------------------------------------------------------------------

#endif // PJYUN_CONTROLS_CARDS_TASK_HPP
