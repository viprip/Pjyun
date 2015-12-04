////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                //
//            Copyright (C) 2015 William McKIE                                                    //
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
#include <QApplication>
#include <QQmlApplicationEngine>

#include <QDir>

//--------------------------------------------------------------------------------------------------
namespace Pjyun {
//--------------------------------------------------------------------------------------------------

/*!
  \brief Returns the QtQuick plugin path of the Pjyun application.
*/
inline QString pluginPath()
{
    auto path = QString{"%1/../lib/pjyun/qml"}.arg(QApplication::applicationDirPath());
    return QDir::cleanPath(path);
}

//--------------------------------------------------------------------------------------------------
} // namespace Pjyun
//--------------------------------------------------------------------------------------------------

int main(int argc, char **argv)
{
    QApplication app{argc, argv};
    QApplication::setApplicationName(QStringLiteral("pjyun"));
    QApplication::setApplicationVersion(QStringLiteral("0.1.0"));
    QApplication::setOrganizationName(QStringLiteral("StoiridhProject"));

    QQmlApplicationEngine engine{};
    engine.addImportPath(Pjyun::pluginPath());
    engine.load(QUrl{QStringLiteral("qrc:/qml/main.qml")});

    return app.exec();
}
