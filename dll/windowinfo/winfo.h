#pragma once
#include <string>

using namespace std;

class WInfo {
public:
    virtual HWND GetHandle()=0;
    virtual wstring GetPath()=0;
    virtual wstring GetName()=0;
    virtual wstring GetTitle()=0;
};
