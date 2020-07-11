#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QFileInfoList>
#include <QStorageInfo>
#include <QTextStream>

#include "fileutils.h"

/*!
   Delete a directory along with all of its contents.

   param dirName Path of directory to remove.
   return true on success; false on error.
*/
bool FileUtils::removeDir(const QString &dirName)
{
    bool result = true;
    QDir dir(dirName);

    if (dir.exists(dirName)) {
        Q_FOREACH(QFileInfo info, dir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden | QDir::AllDirs | QDir::Files, QDir::DirsFirst)) {
            if (info.isDir()) {
                result = removeDir(info.absoluteFilePath());
            }
            else {
                result = QFile::remove(info.absoluteFilePath());
            }

            if (!result) {
                return result;
            }
        }
        result = dir.rmdir(dirName);
    }

    return result;
}


bool FileUtils::mkdir(const QString &dirName)
{
    bool result = QDir().mkdir(dirName);
    return result;
}


qint64 FileUtils::dirSize(const QString &dirPath) {
    qint64 size = 0;
    QDir dir(dirPath);
    //calculate total size of current directories' files
    QDir::Filters fileFilters = QDir::Files|QDir::System|QDir::Hidden;
    for(QString filePath : dir.entryList(fileFilters)) {
        QFileInfo fi(dir, filePath);
        size+= fi.size();
    }
    //add size of child directories recursively
    QDir::Filters dirFilters = QDir::Dirs|QDir::NoDotAndDotDot|QDir::System|QDir::Hidden;
    for(QString childDirPath : dir.entryList(dirFilters))
        size+= dirSize(dirPath + QDir::separator() + childDirPath);
    return size;
}


QString FileUtils::formatSize(const qint64 &size) {
    QStringList units = {"B", "KiB", "MiB", "GiB", "TiB", "PiB"};
    int i;
    double outputSize = size;
    for(i=0; i<units.size()-1; i++) {
        if(outputSize<1024) break;
        outputSize= outputSize/1024;
    }
    return QString("%0 %1").arg(outputSize, 0, 'f', 2).arg(units[i]);
}


QString FileUtils::formattedDirSize(const QString &dirPath) {
    return FileUtils::formatSize(FileUtils::dirSize(dirPath));
}


qint64 FileUtils::totalStorage() {
    QStorageInfo storage = QStorageInfo::root();
    return storage.bytesTotal();
}


qint64 FileUtils::freeStorage() {
    QStorageInfo storage = QStorageInfo::root();
    return storage.bytesFree();
}


bool FileUtils::touch(const QString &path) {
    QFile* file = new QFile(path);
    file->open(QIODevice::ReadWrite);
    return 1;
}


bool FileUtils::rm(const QString &path) {
    QFile* file = new QFile(path);
    file->remove();
    return 1;
}


QString FileUtils::readFile(const QString &path) {
    QFile file(path);
    if (file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        QTextStream in(&file);
        return in.readAll();
    } else {
        return nullptr;
    }
};




