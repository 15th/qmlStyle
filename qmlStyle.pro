TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += \
    qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

#----------------------------------------------------------------
# generate QML folder

searchlist += \
    *.qml \
    *.js \
    *qmldir \

for (searchvar, searchlist) {
    qrclist += $$files($$searchvar, true)
}

OTHER_FILES += $$qrclist # QML folder

#---------------------generate QML folder end-------------------------------------------
# generate qml.qrc

RESOURCE_CONTENT = \
    "<RCC>" \
    "    <qresource prefix=\"/\"> "
for (qrcvar, qrclist) {
        resourcefileabsolutepath = $$absolute_path($$qrcvar)
        relativepath_in = $$relative_path($$resourcefileabsolutepath, $$PWD)
#        relativepath_out = $$relative_path($$resourcefileabsolutepath, $$OUT_PWD)
        RESOURCE_CONTENT += "<file alias=\"$$relativepath_in\">$$relativepath_in</file>"
}
RESOURCE_CONTENT += \
    '    </qresource>' \
    </RCC>
GENERATED_RESOURCE_FILE = $$PWD/qml.qrc
write_file($$GENERATED_RESOURCE_FILE, RESOURCE_CONTENT)
RESOURCES += $$GENERATED_RESOURCE_FILE
QMAKE_PRE_LINK += $(DEL_FILE) $$GENERATED_RESOURCE_FILE
QMAKE_CLEAN += $$GENERATED_RESOURCE_FILE

#--------------------generate qml.qrc end--------------------------------------------

#DISTFILES += \
#    WPTile/WPTile.qml \
#    WPTile/MenuWPTile.qml

DISTFILES += \
    WPTile/WPTileStyle.qml \
    Vertical-ScrollBar/MenuVerticalScrollBar.qml \
    Vertical-ScrollBar/VerticalScrollBar.qml \
    Vertical-ScrollBar/VerticalScrollBarStyle.qml
