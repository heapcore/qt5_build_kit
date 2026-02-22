#include <QApplication>
#include <QtWidgets>

#include "coloritem.h"
#include "robot.h"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);

    QGraphicsScene scene(-150, -150, 300, 300);

    for (int i = 0; i < 10; ++i) {
        auto *item = new ColorItem;
        item->setPos(::sin((i * 6.28) / 10.0) * 150, ::cos((i * 6.28) / 10.0) * 150);
        scene.addItem(item);
    }

    auto *robot = new Robot;
    robot->setTransform(QTransform::fromScale(1.2, 1.2), true);
    robot->setPos(0, -20);
    scene.addItem(robot);

    GraphicsView view(&scene);
    view.setRenderHint(QPainter::Antialiasing);
    view.setViewportUpdateMode(QGraphicsView::BoundingRectViewportUpdate);
    view.setBackgroundBrush(QColor(230, 200, 167));
    view.setWindowTitle("Drag and Drop Robot");
    view.show();

    return app.exec();
}
