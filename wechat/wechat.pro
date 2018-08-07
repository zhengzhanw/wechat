QT += quick
QT += webengine
QT += webenginewidgets
QT += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = wechat
TEMPLATE = app

CONFIG += c++11

include(qxtglobalshortcut5/qxt.pri)

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

RC_ICONS = myico.ico

unix:{
DISTFILES   += appico.rc \
                myico.ico
}

win32:{
RC_FILE     += appico.rc
}

INCLUDEPATH += ../ \
    $(QTDIR)\include\QtANGLE \


SOURCES += \
        main.cpp \
        screenshottool.cpp \
        canvas.cpp \
        KeyString.cpp \
        hotkeybar.cpp \
        rectpaint.cpp \
        linepaint.cpp \
        textpaint.cpp \

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
    screenshottool.qrc \
    qml.qrc


RC_ICONS = ss.ico

TRANSLATIONS += zh_cn.ts \
                en.ts

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

