#ifndef SCREENSHOTTOOL_H
#define SCREENSHOTTOOL_H

/*
 * Author:qiuzhiqian
 * Email:xia_mengliang@163.com
 * Github:https://github.com/qiuzhiqian
 * Date:2017.07.23
 **/

#include <QWidget>
#include <QDialog>
#include <QScreen>
#include <QPixmap>
#include <QMouseEvent>
#include <QDesktopWidget>

#include <QSystemTrayIcon>

#include <QMenu>

#include "canvas.h"
#include "hotkeybar.h"

#include "qxtglobalshortcut.h"

namespace Ui {
class ScreenShotTool;
}

class ScreenShotTool : public QWidget
{
    Q_OBJECT

public:
    explicit ScreenShotTool(QWidget *parent = 0);
    ~ScreenShotTool();

    void initTray();                //初始化托盘
    void ss_start();                //开始截图

    void setHotKey();

    void setAutoRun(bool sta);

    void changeLanguage(QString lan);
    void reFrash();

private:
    Ui::ScreenShotTool *ui;

    Canvas *screenCanvas;

    QPixmap fullPixmap;

    QSystemTrayIcon *m_systemTray;  //系统托盘
    QAction *setAction;
    QAction *aboutAction;
    QAction *exitAction;

    void closeEvent( QCloseEvent * event );     //重写退出
    bool closeFlag=false;

    HotKeyBar *sc_set;

    Qt::Key key;
    Qt::KeyboardModifiers mods;
    KeyString *keystring;

    bool isAutoRun=false;

    QxtGlobalShortcut *shortcut;

signals:
    void appQuit();


private slots:

    void slt_clickTray(QSystemTrayIcon::ActivationReason reason);
    void slt_setAction();
    void slt_aboutAction();
    void slt_exitAction();

    void slt_changeHotKey(Qt::Key t_key, Qt::KeyboardModifiers t_mod);

    void slt_auto_run(int states);
    void slt_language_set(int index);

    void slt_doShot(void);
};

#endif // SCREENSHOTTOOL_H
