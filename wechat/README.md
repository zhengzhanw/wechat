# 概述
这是一个使用QT设计的截图工具

目前效果图
![效果图1](https://raw.githubusercontent.com/qiuzhiqian/ScreenShotTool/master/doc/1.gif)

![效果图2](https://raw.githubusercontent.com/qiuzhiqian/ScreenShotTool/master/doc/2.gif)

![效果图3](https://raw.githubusercontent.com/qiuzhiqian/ScreenShotTool/master/doc/3.gif)

![效果图4](https://raw.githubusercontent.com/qiuzhiqian/ScreenShotTool/master/doc/4.gif)

![效果图5](https://raw.githubusercontent.com/qiuzhiqian/ScreenShotTool/master/doc/3.jpg)

# 历程
## 意动
现在网上免费的截图工具很多，最近用了一款很不错的，叫Snipaste。
这个软件就是基于QT开发的，不过并没有开源，软件设计的很好用，界面也很清新，于是我也想自己尝试这设计一个这样的工具来练练手。
于是就有了这样的一个工程

## 参考
虽然有了想法，但是还是完全不知道怎么办啊。不用担心，QT有大把的官方例程。
我从官方找到了一个叫做sceenshot的例程，这是一个简单的全屏截图的例子，从这个例子中，我们知道了两个重要的东西
1. **获取屏幕分辨率**
	
    ```
    const QRect screenGeometry = QApplication::desktop()->screenGeometry(this);
    screen_width=screenGeometry.width();
    screen_height=screenGeometry.height();
    ```
2. **截图API**
	
    ```
    QScreen *screen = QGuiApplication::primaryScreen();
    originalPixmap = screen->grabWindow(0,x,y,width,height);
    ```
    
其实，在有了以上两个知识后，我们就已经可以截取屏幕上的任意区域的图片了。
grabWindow这个函数我也最关心的就是四个参数x,y,width,height。这四个参数就是一个矩形框参数，只要给定了这四个参数，想截哪里截哪里。
比如我想截取屏幕上的从点(30,50)-->(240,350)的区域截图

```
QScreen *screen = QGuiApplication::primaryScreen();
originalPixmap = screen->grabWindow(0,30,50,(240-30),(350-50));
```

## 思考
那么用户在使用过程中，如何通过交互将这四个参数传递给程序呢？方法还是很多的，比如：
1. 我设计四个输入框，用户在截屏前先手动输入这四个参数对应的值，然后点击按键截屏。嗯...想想都感觉好傻。
2. 用鼠标选定一个区域，然后将矩形区域转化为这四个参数值，然后截屏。嗯大家都是这么干的，既然如此，我也这么来吧。

那么，我们的方案基本定下来了，即用户通过点击左键并拖动鼠标来选择需要截屏的区域，然后程序将坐标传递给grabWindow，从而完成截图。

1. 由于我们需要通过点击鼠标、拖动鼠标这些动作完成一些特定的功能，所以我们需要重载各种鼠标事件。
2. 为了让用户知道自己拖动的范围在什么地方，所以在拖动时要绘制出矩形的图形，即我们需要绘制矩形。

所以我们的步骤是：
1. 用户触发截图动作
2. 用户开始截图，按下鼠标左键然后拖动来选定区域，并实时将选在的区域显示在屏幕上
3. 完成截图，图片保存到本地或剪切板

## 深入
现在有了上面的步骤，我们就按照这个步骤来实现，我们可以看到，主要的任务都在第二步。
那么要实现第二步，我们又会想到一些问题：

```
问：我们要绘制矩形框，这个矩形框绘制在什么上面？
思考：由QT的特性可以绘制在QWidget或者继承自QWidget的控件上
答:QWidget及QWidget属性控件
```

```
问：这个控件有什么特性？
思考：我们来仔细思考一下截图时拖动选框的过程，首先我们能看到整个屏幕当前的画面，然后鼠标可以在整个屏幕范围移动，绘制区域可以在整个屏幕内选择。
当然还有一点，我们鼠标的动作都是在这个控件上完成的，那么这个控件必须在所有窗体的顶层，即置顶。
答：全屏，显示屏幕画面，置顶
```

```
问：全屏和置顶好实现，显示屏幕画面怎么弄？
思考：由于我们的绘图控件是全屏的，并且置顶的，那么其实屏幕画面是在这个绘图控件的下面，即要截屏的画面被绘图控件(以下称为画布)挡住了。
所以要实现画布显示屏幕画面有两种方法。
第一种就是让画布透明，画布是透明的，自然就能够显示到下面的屏幕画面了。
第二种方法就是在屏幕画面被画布挡住之前将屏幕截下来，然后将这个截取的图片显示到幕布上，此处我们用第二种方法来实现。
答：在画布显示之前先截取屏幕图片，然后显示画布，然后之前截取的屏幕画面在画布上显示。
```

所以。通过以上的问答，基本就确定了我们的设计思路。

## 最终思路

1、触发截图(快捷键或单击图标)  
2、截取全屏画面  
3、显示画布，画布全屏，画布置顶，画布显示之前截取的全屏画面  
4、通过重写鼠标和绘图函数来达到显示鼠标拖动区间，  
5、截取鼠标拖动区间图案，弹出保存选项  
6、手动调整截图区域  
7、添加线、矩形以及椭圆标记功能，设置标记画笔  
8、保存截屏到文件或保存截屏到剪切板或放弃截屏  
9、退出  

## 待完善功能
1、标记大小位置调整  

# 多语言  
本源码提供了两种内置语言的翻译文件：英文和中文。  
- 英文翻译文件:en.ts  
- 中文翻译文件:zh_cn.ts  

## 使用方法  
### 1、生成ts对应的qm文件  
方法一：使用打开源代码，选择"工具"->"外部"->"Qt语言专家"->"发布翻译"，然后得到对应的qm文件。  
方法二：直接使用qtcreator对应的翻译家Linguist生成对应的qm文件，具体使用方法自行了解。  
### 2、将qm文件放置于运行目录下  
使用qtcreator时编译调试时类似于build-ScreenShotTool-Desktop_Qt_5_9_0_MinGW_32bit-Debug目录下  
发布时请至于ScreenShotTool执行程序的同级目录下

# 使用
使用很简单，无需过多介绍，展示一些示意图  
英文界面

![英文界面](https://raw.githubusercontent.com/qiuzhiqian/ScreenShotTool/master/doc/1.jpg)

中文界面

![中文界面](https://raw.githubusercontent.com/qiuzhiqian/ScreenShotTool/master/doc/2.jpg)

## 提醒

如果发现软件的中文无法起作用，可以按以下步骤处理：  
1、请确保你的软件安装目录下面有en.qm何zh_cn.qm这两个文件  
2、如果有这两个文件，但仍然不起作用，请确保你的qm文件和本软件的版本是兼容的  
3、如果以上的方法都没有用，请下载本软件源码，自行编译二进制文件，同时更新qm文件  
4、如果以上还无法解决，请联系我