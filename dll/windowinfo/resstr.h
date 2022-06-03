#pragma once
#include <string>

enum ResultStringType {
	STR,
	WSTR,
	NONE
};

using namespace std;
class ResultString {
private:
	ResultStringType type;
	string str;
	wstring wstr;

public:
	ResultString();
	const char* c_str();
	const wchar_t* utf16();

	string& operator=(string&);
	wstring& operator=(wstring&);
	const char* operator=(const char*);
	const wchar_t* operator=(const wchar_t*);
};