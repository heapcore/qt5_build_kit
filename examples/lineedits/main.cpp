#include <QApplication>

#include "lineedits.h"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);

    LineEdits lineEdits;
    lineEdits.show();

    return app.exec();
}
