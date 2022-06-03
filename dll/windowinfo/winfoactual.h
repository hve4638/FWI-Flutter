#pragma once
#include <windows.h>
#include "winfo.h"

class WInfoActual : public WInfo {
private:
    HWND handle;
    wstring name;
    wstring title;
    wstring path;

    wstring getPath(HWND);
    wstring getName(wstring);
    wstring getWindowTitle(HWND);
public:
    WInfoActual();

    virtual HWND GetHandle() { return handle; }
    virtual wstring GetPath();
    virtual wstring GetName();
    virtual wstring GetTitle();
};

