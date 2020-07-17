include($$PWD/vendor.pri)
include($$PWD/hook/hooks.pri)

QT       += network
QT       -= gui

TARGET = libdbm
TEMPLATE = lib
CONFIG += staticlib c++11 link_pkgconfig
DEFINES += TOOLS_DIR=\\\"'$${PREFIX}/share/deepin-boot-maker/hooks'\\\"

SOURCES += \
    backend/bootmaker.cpp \
    backend/diskutil.cpp \
    backend/syslinux.cpp \
    util/devicemonitor.cpp \
    util/sevenzip.cpp \
    util/utils.cpp \
    bminterface.cpp

HEADERS += \
    backend/bmhandler.h \
    backend/bootmaker.h \
    backend/diskutil.h \
    backend/syslinux.h \
    util/deviceinfo.h \
    util/devicemonitor.h \
    util/sevenzip.h \
    util/utils.h \
    bminterface.h

linux {
HEADERS += \
    backend/bmdbusinterface.h \
    backend/bmdbushandler.h

SOURCES += \
    backend/bmdbusinterface.cpp
}

unix {
    target.path = /usr/lib
#    INSTALLS += target
}

linux {
isEqual(ARCH, i386) | isEqual(ARCH, x86_64){
linux {
binary.path = $${PREFIX}/bin
binary.files = $$PWD/qrc/xfbinst_x64 \
               $$PWD/qrc/xfbinst_x32

tools.path = $${PREFIX}/share/deepin-boot-maker/hooks
tools.files = $$PWD/hooks/rename_limit_file.sh
INSTALLS += binary desktop hicolor tools
}
}
}

linux {
    RESOURCES += blob_linux.qrc
} else {
    RESOURCES += blob.qrc
}
