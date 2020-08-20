#ifndef FILEUTILS_H
#define FILEUTILS_H

#include <QObject>

class FileUtils : public QObject {
	Q_OBJECT
public:
	explicit FileUtils (QObject* parent = 0) : QObject(parent) {}
	Q_INVOKABLE static bool mkdir(const QString &dirName);
	Q_INVOKABLE static bool removeDir(const QString &dirName);
	Q_INVOKABLE static qint64 dirSize(const QString &dirPath);
	Q_INVOKABLE static QString formatSize(const qint64 &size);
	Q_INVOKABLE static QString formattedDirSize(const QString &dirPath);
	Q_INVOKABLE static qint64 totalStorage();
	Q_INVOKABLE static qint64 freeStorage();
	Q_INVOKABLE static void touch(const QString path);
	Q_INVOKABLE static void rm(const QString path);
	Q_INVOKABLE static QString readFile(const QString path);
	Q_INVOKABLE static void writeFile(const QString path, const QString txt);
	Q_INVOKABLE static QString whoami(void);
	Q_INVOKABLE static void mount(const QString configPath, const QString remotePath);
private:
	static std::string exec(const char* cmd);
};

#endif // FILEUTILS_H
