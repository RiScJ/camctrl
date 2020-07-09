#include <QDir>
#include <QFile>
#include <QFileInfo>
#include <QFileInfoList>

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
        Q_FOREACH(QFileInfo info, dir.entryInfoList(QDir::NoDotAndDotDot | QDir::System | QDir::Hidden  | QDir::AllDirs | QDir::Files, QDir::DirsFirst)) {
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
