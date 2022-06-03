#include <iostream>
#include <windows.h>
#include <wchar.h>
#include <string>
#include <tlhelp32.h>
#include "winfoactual.h"

using namespace std;
using std::string;

//#define TCharToChar(srcTChar, destChar) WideCharToMultiByte(CP_ACP, 0, srcTChar, sizeof(srcTChar), destChar, sizeof(destChar), NULL, NULL);

wstring WInfoActual::getPath(HWND hwnd) {
    DWORD processId;
    GetWindowThreadProcessId(hwnd, &processId);

    HANDLE hProc = OpenProcess(
        PROCESS_QUERY_LIMITED_INFORMATION,
        FALSE,
        processId
    );

    if (hProc) {
        const int len = 512;
        TCHAR tbuf[len];
        DWORD bufLen = sizeof(tbuf)/sizeof(TCHAR);
        QueryFullProcessImageName(hProc, 0, tbuf, &bufLen);

        CloseHandle(hProc);

        return tbuf;
    }
    else {
        return L"unknown";
    }
}

wstring WInfoActual::getWindowTitle(HWND hwnd) {
    TCHAR title[512] = L"Default";

    GetWindowTextW(hwnd, title, sizeof(title)/sizeof(TCHAR)-1);
    return title;
}

wstring WInfoActual::getName(wstring path) {
    auto len = path.length();
    if (len == 0) {
        return L"";
    }

    auto pos = path.find_last_of(L"\\");
    if (pos == wstring::npos) {
        return path;
    }
    else if (pos >= len-1) {
        return L"";
    }
    else {
        return path.substr(pos+1);
    }
}

WInfoActual::WInfoActual(){
    handle = GetForegroundWindow();
    path = L"";
    name = L"";
    title = L"";
}


wstring WInfoActual::GetPath() {
    if (path.empty()) {
        path = getPath(handle);
    }
    return path;
}
wstring WInfoActual::GetName() {
    if (name.empty()) {
        name = getName(GetPath());
    }
    return name;
}
wstring WInfoActual::GetTitle() {
    if (title.empty()) {
        title = getWindowTitle(handle);
    }
    return title;
}