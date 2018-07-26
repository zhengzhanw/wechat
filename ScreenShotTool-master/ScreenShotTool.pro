#-------------------------------------------------
#
# Project created by QtCreator 2017-07-18T14:06:17
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = ScreenShotTool
TEMPLATE = app

include(qxtglobalshortcut5/qxt.pri)

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked as deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0


SOURCES += \
        main.cpp \
        screenshottool.cpp \
    canvas.cpp \
    KeyString.cpp \
    hotkeybar.cpp \
    rectpaint.cpp \
    linepaint.cpp \
    textpaint.cpp

HEADERS += \
    screenshottool.h \
    canvas.h \
    KeyString.h \
    hotkeybar.h \
    operateSet.h \
    rectpaint.h \
    linepaint.h \
    textpaint.h

FORMS += \
        screenshottool.ui

RESOURCES += \
    screenshottool.qrc

RC_ICONS = ss.ico

TRANSLATIONS += zh_cn.ts \
                en.ts
