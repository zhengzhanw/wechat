#ifndef CANVAS_H
#define CANVAS_H

/*
 * Author:qiuzhiqian
 * Email:xia_mengliang@163.com
 * Github:https://github.com/qiuzhiqian
 * Date:2017.07.23
 **/

#include <QApplication>
#include <QWidget>
#include <QLabel>
#include <QMouseEvent>
#include <QPainter>
#include <QPaintEvent>
#include <QDesktopWidget>
#include <QScreen>
#include <QPixmap>
#include <QGuiApplication>
#include <QPen>
#include <QApplication>

#include <QPushButton>

#include <QFileDialog>

#include <QHBoxLayout>
#include <QClipboard>

#include <QComboBox>

#include <QColorDialog>
#include <QFontDialog>

#include "linepaint.h"
#include "rectpaint.h"
#include "textpaint.h"

enum DrawStatus {
    waitDraw=0,
    drawing,
    drawed,
};


class Canvas : public QWidget
{
    Q_OBJECT
public:
    explicit Canvas(QWidget *parent = 0);

    void setbgPixmap(QPixmap &px);
    void shootScreen(QRectF &rect);

    void canvasInit();

    void initToolBar();
    void showToolBar();
    void hideToolBar();
    void refrashToolBar();

    //void initShapeToolBar();
    //void showShapeToolBar();
    //void hideShapeToolBar();

    //void initShapeToolBar();
    //void showShapeToolBar();
    //void hideShapeToolBar();

    quint8 caputerRect(QRectF t_rect,qreal t_x,qreal t_y);

    RectPaint getRectF(QPointF p1,QPointF p2);    //通过两个坐标点生成矩形

    void changeLanguage(QString lan);

signals:

public slots:
    void slt_drawLine();
    void slt_drawRect();
    void slt_drawEllipse();
    void slt_drawText();
    void slt_saveFile();            //保存到文件
    void slt_saveClipboard();       //保存到剪切板
    void slt_cancel();

    void slt_changePenWidth(QString s);
    void slt_changePenColor();
    void slt_changePenStyle(int index);

    void slt_changeTextColor();
    void slt_changeTextFont();

private:
    int screen_width=0,screen_height=0;
    quint8 okFlag=0;

    QPointF pointS;     //鼠标绘制起点
    QPointF pointE;     //鼠标绘制终点
    RectPaint shotArea;    //截图区域

    QList<LinePaint> lineList;         //直线列表
    QList<RectPaint> rectList;         //矩形列表
    QList<RectPaint> ellipseList;      //椭圆列表
    QList<TextPaint *> textList;          //文本列表

    QPointF pointDrag;              //拖拽点

    DrawStatus rectFlag=DrawStatus::waitDraw;
    quint8 drawEditFlag=0;          //绘图修改

    QPixmap fullPixmap;         //原始全屏图片
    QPixmap originalPixmap;

    QWidget *toolbar;           //工具条
    QPushButton *btn_saveFile;
    QPushButton *btn_saveClipboard;
    QPushButton *btn_cancel;
    QPushButton *btn_drawLine;      //画直线
    QPushButton *btn_drawRect;      //画矩形
    QPushButton *btn_drawEllipse;   //画椭圆
    QPushButton *btn_drawText;      //添加文本

    QPen drawPen;                   //线宽颜色风格
    QWidget *shapeToolBar;
    QWidget *textToolBar;

    int toolBarWidth;
    int toolBarHeight;

    QComboBox *cbx_lineSize;
    QPushButton *btn_colorSelect;
    QComboBox *cbx_lineStyle;

    QPushButton *btn_colorText;
    QPushButton *btn_FontText;
    QColor textcolor;
    QFont textfont;

    QClipboard *clipboard;

    quint8 cursorCaptureFlag=0;

    void mousePressEvent(QMouseEvent *event);
    void mouseMoveEvent(QMouseEvent *event);
    void mouseReleaseEvent(QMouseEvent *event);
    void paintEvent(QPaintEvent *e);
};

#endif // CANVAS_H
