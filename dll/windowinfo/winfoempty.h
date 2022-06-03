#pragma once
#include "winfo.h"

class WInfoEmpty : public WInfo {
public:
    virtual HWND GetHandle() { return NULL; }
    virtual wstring GetPath() { return L"unknown"; }
    virtual wstring GetName() { return L"unknown"; }
    virtual wstring GetTitle() { return L"unknown"; }
};